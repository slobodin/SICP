;; Example 1.45

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 0) (lambda (x) x)
      (compose (repeated f (- n 1)) f)))

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

(define (my-sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))

(my-sqrt 16)

(define (my-4-root x)
  (fixed-point (repeated (average-damp 
                          (lambda (y) 
                            (/ x (* y y y))))
                         2)
               1.0))

(my-4-root 4096)

;; Full procedure
