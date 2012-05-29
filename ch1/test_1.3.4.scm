;; Part 1.3.4

(define tolerance 0.00001)

(define (close-enough? a b)
  (< (abs (- a b)) tolerance))

(define (average a b)
  (/ (+ a b) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (square x)
  (* x x))

(define (fixed-point f first-guess)
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

((average-damp square) 10)

(define (my-sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))

(my-sqrt 16)

(define (my-cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (* y y))))
               1.0))

(my-cube-root 27)