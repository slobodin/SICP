;; Example 2.27

(define x (list (list 1 2) (list 3 4)))
x

(reverse x)
(list? x)

(define (deep-reverse items)
  