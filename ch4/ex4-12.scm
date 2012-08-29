;; Example 4.12

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

;; kind of abstraction, lol
(define (scan-helper vars vals env eqVar onEq)
  (cond ((null? vars)
         (env-loop (enclosing-environment env)))
        ((eq? eqVar (car vars))
         (onEq vars vals))
        (else (scan-helper (cdr vars) (cdr vals) env eqVar onEq))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan-helper (frame-variables frame)
                       (frame-values frame)
                       env
                       var
                       (lambda (vr vl) (car vl))))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan-helper (frame-variables frame)
                       (frame-values frame)
                       env
                       var
                       (lambda (vr vl) (set-car! vl val))))))
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

;; Test

(define variables '(x y z))
(define vals '(42 24 -5))
(define frame (make-frame variables vals))
(define env (list frame))

(display "Original frame :\n")
frame

(add-binding-to-frame! 'q 100 frame)
(display "After adding (q:100) :\n")
frame

(display "Lookup added vars :\n")
(lookup-variable-value 'x env)
(lookup-variable-value 'y env)
(lookup-variable-value 'z env)
(lookup-variable-value 'q env)

(display "Setting some vars to new vals :\n")
(set-variable-value! 'x 2 env)
(set-variable-value! 'q 1 env)
frame

(display "Definition (t:2) :\n")
(define-variable! 't 2 env)
frame