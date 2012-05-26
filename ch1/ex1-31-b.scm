;; Example 1.31.b

;; linear-iterative
(define (product func a next b)
  (define (iter sum curr-a)
    (if (> curr-a b)
        sum
        (iter (* sum (func curr-a)) (next curr-a))))
  (iter 1 a))

(define (identity x) x)
(define (inc n) (+ n 1))

(define (factorial n)
  (product identity 1 inc n))

(factorial 1)
(factorial 2)
(factorial 3)
(factorial 4)
(factorial 5)
(factorial 6)