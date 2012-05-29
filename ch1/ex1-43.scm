;; Example 1.43

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 0) (lambda (x) x)
      (compose (repeated f (- n 1)) f)))

(define (square a)
  (* a a))

((repeated square 2) 5)