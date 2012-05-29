;; Example 1.44

(define (average a b c)
  (/ (+ a b c) 3))

(define (square a)
  (* a a))

(define dx 0.00001)

(define (smooth-function f)
  (lambda (x) (average (f (- x dx)) (f x) (f (+ x dx)))))

((smooth-function square) 2)