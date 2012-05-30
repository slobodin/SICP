;; Example 2.4

(define (my-cons x y)
  (lambda (m) (m x y)))

(define (my-car z)
  (z (lambda (p q) p)))

(my-car (my-cons 1 2))

;; (my-car (my-cons 1 2))
;; (my-car 
;;   (lambda (m) (m 1 2))))
;; ((lambda (m) (m 1 2)) (lambda (p q) p))
;; lambda (p q) p (1 2)
;; 1
;; That is
;; lambda m applies to lambda p q and returns either p or q

(define (my-cdr z)
  (z (lambda (p q) q)))

(my-car (my-cons 6 7))
(my-cdr (my-cons 6 7))