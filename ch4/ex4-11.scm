#|#lang racket
(require r5rs)|#

;; Example 4.11

;; environment

;; environment is the list of frames
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())

;; frame is list of bindings (var:val)
(define (make-frame variables values)
  (cond ((or (null? variables) (null? values))
         '())
        ((= (length variables) (length values))
         (cons (cons (car variables) (car values))
               (make-frame (cdr variables) (cdr values))))
        (else (error "Different size -- MAKE_FRAME" variables values))))

(define (add-binding-to-frame! var val frame)
  (let ((new-binding (list (cons var val))))
    (if (null? (cdr frame))
        (set-cdr! frame new-binding)
        (add-binding-to-frame! var val (cdr frame)))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan frame)
      (cond ((null? frame)
             (env-loop (enclosing-environment env)))
            ((eq? var (caar frame))
             (cdar frame))
            (else (scan (cdr frame)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (scan (first-frame env))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan frame)
      (cond ((null? frame)
             (env-loop (enclosing-environment env)))
            ((eq? var (caar frame))
             (set-cdr! (car frame) val))
            (else (scan (cdr frame)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (scan (first-frame env))))
  (env-loop env))

(define (define-variable! var val env)
  (define (scan frame)
    (cond ((null? frame)
           (add-binding-to-frame! var val (first-frame env)))
          ((eq? var (caar frame))
           (set-cdr! (car frame) val))
          (else (scan (cdr frame)))))
  (scan (first-frame env)))

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