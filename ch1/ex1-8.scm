;; Example 1.8
;; Cube root.

;; average between two numbers
(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

;; newtone`s method
(define (improve y x)
  (/ (+ (/ x (square y)) (* 2 y)) 3))

;; is (x-prevx) < eps
(define (good-enough? a b)
  (< (abs (- (cube a) b)) 0.001))

;; eval sqrt
(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x)
                      x)))

;; standart call
(define (my-cube-root x)
  (cube-root-iter 1.0 x))

;; test
(my-cube-root 8)
(my-cube-root 125)
(my-cube-root 27)
(my-cube-root 1.0)