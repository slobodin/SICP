;; Example 1.17

(define (mul a b)
  (if (= b 0) 0
      (+ a (mul a (- b 1)))))

(mul 2 5)
(mul 4 5)
(mul 3 15)

(define (double x)
  (* x 2))

(define (half x)
  (/ x 2))

(define (fast-mul a b)
  (define (iter res a b)
    (