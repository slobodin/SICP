(#%require racket/bool)

;; utils

(define apply-in-underlying-scheme apply)

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      #f))

(define (error reason . args)
  (display "Error: ")
  (display reason)
  (for-each (lambda (arg)
              (display " ")
              (write arg))
            args)
  (newline)
  (scheme-report-environment -1))  ;; we hope that this will signal an error

;; Eval

(define (meval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((and? exp) (eval-and (and-operands exp) env))
        ((or? exp) (eval-or (or-operands exp) env))
        ((let? exp) (meval (let->combination (cdr exp)) env))
        ((let*? exp) (meval (let*->nested-lets (cdr exp)) env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (meval (cond->if exp) env))
        ((application? exp)
         (mapply (meval (operator exp) env)                 ;; apply procedure (proc, args)
                 (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))

;; Apply

(define (mapply procedure arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           (procedure-parameters procedure)
           arguments
           (procedure-environment procedure))))
        (else
         (error "Unknown procedure type -- APPLY" procedure))))

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (meval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))

(define (eval-if exp env)
  (if (true? (meval (if-predicate exp) env))
      (meval (if-consequent exp) env)
      (meval (if-alternative exp) env)))

(define (eval-sequence exps env)
  (cond ((last-exp? exps) (meval (first-exp exps) env))
        (else (meval (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))

(define (eval-assignment exp env)
  (set-variable-value! (assignment-variable exp)
                       (meval (assignment-value exp) env)
                       env)
  'ok)

(define (eval-definition exp env)
  (define-variable! (definition-variable exp)
                    (meval (definition-value exp) env)
                    env)
  'ok)

;; Syntax

;; self-evaluating - only numbers and strings
(define (self-evaluating? exp)
  (cond ((number? exp) #t)
        ((string? exp) #t)
        (else #f)))

;; var = symbol
(define (variable? exp) (symbol? exp))

;; quotation
(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (text-of-quotation exp) (cadr exp))

;; assignment
(define (assignment? exp)
  (tagged-list? exp 'set!))

(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))

;; definition of vars and procs
(define (definition? exp)
  (tagged-list? exp 'define))

(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)          ;; define variable
      (caadr exp)))       ;; define procedure

(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)                         ;; value for variable
      (make-lambda (cdadr exp)            ;; value for procedure
                   (cddr exp))))

;; lambdas
(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

;; and
(define (and? exp) (tagged-list? exp 'and))
(define (and-operands exp) (cdr exp))
(define (eval-and exp env)
  (cond ((null? exp) 'true)
        ((false? (meval (car exp) env)) 'false)
        (else (eval-and (cdr exp) env))))

;; or
(define (or? exp) (tagged-list? exp 'or))
(define (or-operands exp) (cdr exp))
(define (eval-or exp env)
  (cond ((null? exp) 'false)
        ((true? (meval (car exp) env)) 'true)
        (else (eval-or (cdr exp) env))))

;; if stuff
(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))
(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

;; let stuff
(define (let? exp)
  (tagged-list? exp 'let))
(define (let-body exp) (cdr exp))
(define (let-vars-and-exps exp) (car exp))
(define (let-vars exp)
  (if (null? exp)
      '()
      (cons (caar exp) (let-vars (cdr exp)))))
(define (let-exps exp)
  (if (null? exp)
      '()
      (cons (cadar exp) (let-vars (cdr exp)))))
(define (let->combination exp)
  (cons (make-lambda (let-vars (let-vars-and-exps exp)) (let-body exp))
        (let-exps (let-vars-and-exps exp))))

;; let* stuff
(define (let*? exp)
  (tagged-list? exp 'let*))
(define (let*-body exp) (cdr exp))
(define (let*-vars-and-exps exp) (car exp))
(define (let*->nested-lets exp)
  (define (helper var-exps body)
    (if (null? (cdr var-exps))
        (cons 'let (cons var-exps body))    ;; final let
        (list 'let (list (car var-exps))
              (helper (cdr var-exps) body))))
  (helper (let*-vars-and-exps exp) (let*-body exp)))

;; begin
(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))
(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))

;; procedure invocation
(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

;; compound cond
(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))
(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "Clause else not the last" clauses))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-actions first))
                     (expand-clauses rest))))))

;; data structures

(define (true? x)
  (not (eq? x false)))

(define (false? x)
  (eq? x false))

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))

(define (compound-procedure? p)
  (tagged-list? p 'procedure))

(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))

;; environment

;; environment is the list of frames
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())

;; frame is the two lists: list of variables and list of values
(define (make-frame variables values)
  (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))      ;; mutable append (frame = x + frame)
  (set-cdr! frame (cons val (cdr frame))))

;; create new frame(vars, vals) and ptr to base env
(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (car vals))
            (else (scan (cdr vars) (cdr vals)))))    
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))  
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars))
             (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))

(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

(define (primitive-implementation proc) (cadr proc))

(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list '+ +)
        (list '- -)
        (list '/ /)
        (list '* *)
        ))

(define (primitive-procedure-names)
  (map car primitive-procedures))

(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc))) primitive-procedures))

(define (setup-environment)
  (let ((initial-env
         (extend-environment (primitive-procedure-names)
                             (primitive-procedure-objects)
                             the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

(define the-global-environment (setup-environment))

(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme (primitive-implementation proc) args))

;; driver loop

(define input-promt ";;; M-Eval input:")
(define output-promt ";;; M-Eval value:")

(define (driver-loop)
  (promt-for-input input-promt)
  (let ((input (read)))
    (let ((output (meval input the-global-environment)))
      (announce-output output-promt)
      (user-print output)))
  (driver-loop))

(define (promt-for-input string)
  (newline) (newline) (display string) (newline))

(define (announce-output string)
  (newline) (display string) (newline))

(define (user-print object)
  ;(display the-global-environment))
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))

the-global-environment
(driver-loop)