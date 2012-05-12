;; Example 1.7
;; Improved square
;; Checks (x - prevx) < eps instead of
;; (x * x - desired) < eps

;; average between two numbers
(define (avg a b)
  (/ (+ a b) 2))

;; newtones method
(define (improve y x)
  (avg y (/ x y)))

;; is (x-prevx) < eps
(define (good-enough? a b)
  (< (abs (- a b)) 0.001))

;; eval sqrt
(define (sqrt-iter y prevy x)
  (if (good-enough? y prevy)
      y
      (sqrt-iter (improve y x)
                 y
                 x)))

;; standart call
(define (my-sqrt x)
  (sqrt-iter 1.0 x x))

;; test
(my-sqrt 4)
(my-sqrt 2.0)
(my-sqrt 9)
(my-sqrt 1.0)

