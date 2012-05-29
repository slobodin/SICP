;; Example 1.42

(define (compose f g)
  (lambda (x) (f (g x))))

(define (square a)
  (* a a))
(define (inc n)
  (+ n 1))

((compose square inc) 6)