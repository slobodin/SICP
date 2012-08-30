;; Example 4.16

;; Merged to interpreter.

;; Needed stuff from the interpreter

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      #f))

(define (make-begin seq) (cons 'begin seq))

(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

(define (definition? exp)
  (tagged-list? exp 'define))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))
(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)
                   (cddr exp))))

;; Desired function

(define (scan-out-defines proc-body)
  (define (iter body vars exps)
    (if (or (null? body) (not (definition? (car body))))
        (list vars exps body)
        (iter (cdr body) 
              (cons (definition-variable (car body)) vars)
              (cons (definition-value (car body)) exps))))
  (let ((scan-res (iter proc-body '() '())))
    (let ((vars (car scan-res))
          (exps (cadr scan-res))
          (rest-body (caddr scan-res)))
      (list (list 'let 
                  (map (lambda (var) (list var ''*unassigned*)) vars)
                  (make-begin (append (map (lambda (var exp) (list 'set! var exp)) vars exps)
                                      rest-body)))))))

;; Test

(define t '(lambda (x)
             (define u (+ 2 2))
             (define v (+ 3 3))
             (define (square x)
               (* x x))
             (+ u v)
             (+ u u u)))

(scan-out-defines (lambda-body t))

;; install into make-procedure
;; installing into getter is bad idea