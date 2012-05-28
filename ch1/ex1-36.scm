;; Example 1.36

(define (average a b)
  (/ (+ a b) 2.0))

(define tolerance 0.00001)

(define (close-enough? a b)
  (< (abs (- a b)) tolerance))

(define (fixed-point f first-guess)
  (define (try guess)
    (display "Trying guess ")
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (solve-eq first-guess)
  (fixed-point (lambda (x) (/ (log 1000) (log x))) first-guess))

(solve-eq 30.0)

(define (solve-eq-average first-guess)
  (fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) first-guess))

(display "-----AVERAGE-----\n")

(solve-eq-average 30.0)