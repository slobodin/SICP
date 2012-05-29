;; Example 1.40

(define tolerance 0.00001)

(define (close-enough? a b)
  (< (abs (- a b)) tolerance))

(define (fixed-point f first-guess)
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define dx 0.00001)

(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (cubic a b c)
  (lambda (x) (+ (* x x x)
                 (* a (* x x))
                 (* b x)
                 c)))

(define (newton-method g guess)
  (fixed-point (newton-transform g) guess))

(newton-method (cubic 0 0 0) 1.0)