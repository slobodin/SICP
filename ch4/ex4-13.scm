;; Example 4.13

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

(define (make-unbound! var env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (error "Can't find variable to unbound" var))
            ((eq? var (car vars))
             (set-car! vals '())
             (set-car! vars '()))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))

(define variables '(x y z))
(define vals '(42 24 -5))
(define frame (make-frame variables vals))
(define env (list frame))

(display "Original frame :\n")
frame

(add-binding-to-frame! 'q 100 frame)
(display "After adding (q:100) :\n")
frame

(display "Definition (t:2) :\n")
(define-variable! 't 2 env)
frame

(display "Unbounding x :\n")
(make-unbound! 'x env)
frame