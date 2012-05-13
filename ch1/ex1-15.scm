;; Example 1.15.

;; sin(x) = 3sin(x/3) - 4sin^3(x/3)
;; sin(x) ~= x, x <= 0.1 rad

(define (cube x)
  (* x x x))

(define (p x)
  (- (* 3 x) (* (cube x) 4)))

(define (sine x)
  (if (not (> (abs x) 0.1)) x
      (p (sine (/ x 3.0)))))

(sine (/ 3.1415 2))
(sine 3.1415)
(sine 12.15) 

;; Answer a - 6 iterations
;; Answer b - ~log3(a) memory and steps