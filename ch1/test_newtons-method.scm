;; Newtons method

(define tolerance 0.00001)

(define (close-enough? a b)
  (< (abs (- a b)) tolerance))

(define (average a b)
  (/ (+ a b) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

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

(define (cube x)
  (* x x x))

((deriv cube) 5.0)

(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (newton-method g guess)
  (fixed-point (newton-transform g) guess))

(newton-method (lambda (x) (* x x)) 1.0)

(define (sqrt-newton x)
  (newton-method (lambda (y) (- (* y y) x)) 1.0))

(sqrt-newton 2.0)
(sqrt-newton 4.0)

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (sqrt-test-1 x)
  (fixed-point-of-transform (lambda (y) (/ x y))
                            average-damp
                            1.0))

(sqrt-test-1 4.0)

(define (sqrt-test-2 x)
  (fixed-point-of-transform (lambda (y) (- (* y y) x))
                            newton-transform
                            1.0))

(sqrt-test-2 4.0)