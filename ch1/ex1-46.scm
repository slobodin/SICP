;; Example 1.46

(define (iterative-improve good? improve)
  (lambda (first)
    (define (try guess)
      (let ((next (improve guess)))
        (if (good? guess next)
            next
            (try next))))
    (try first)))

(define tolerance 0.0001)

(define (average a b) 
  (/ (+ a b) 2.0))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (my-sqrt n)
  ((iterative-improve
    (lambda (guess next) (< (abs (- guess next)) tolerance))
    (average-damp (lambda (y) (/ n y))))
   1.0))

(my-sqrt 4.0)

(define (fixed-point f first)
  ((iterative-improve
    (lambda (guess next) (< (abs (- guess next)) tolerance))
    f)
   first))