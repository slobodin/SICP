(define (my-cons x y)
  (define (dispatch m)
    (cond ((eq? m 'car) x)
          ((eq? m 'cdr) y)
          (else (error "Undefined operation -- CONS" m))))
  dispatch)

(define (my-car z) (z 'car))
(define (my-cdr z) (z 'cdr))

(define z (my-cons 1 2))

(my-car z)
(my-cdr z)

;; assignable

(define (my-cons-assign x y)
  (define (set-x! v) (set! x v))
  (define (set-y! v) (set! y v))
  (define (dispatch m)
    (cond ((eq? m 'car) x)
          ((eq? m 'cdr) y)
          ((eq? m 'set-car!) set-x!)
          ((eq? m 'set-cdr!) set-y!)
          (else (error "Undefined operation -- CONS-ASSIGN" m))))
  dispatch)

(define (my-car-assign z) (z 'car))
(define (my-cdr-assign z) (z 'cdr))
(define (my-set-car! z v) ((z 'set-car!) v) z)
(define (my-set-cdr! z v) ((z 'set-cdr!) v) z)

(define z1 (my-cons-assign 'x 'y))

(my-car-assign z1)
(my-cdr-assign z1)

(my-set-car! z1 'a)
(my-set-cdr! z1 'b)

(my-car-assign z1)
(my-cdr-assign z1)

