;; Example 1.35

;; Golden ratio:
;; Ф^2 = Ф + 1
;; Ф = 1 + 1/Ф
;; fixed point - f(x) = x

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

;; x -> 1 + 1 / x

(define (find-golden-ratio first-guess)
  (fixed-point (lambda (x) (+ 1 (/ 1 x))) first-guess))

(find-golden-ratio 1.0)