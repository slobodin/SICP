;; 1.1.7

(define (square x)
  (* x x))

(define (avg a b)
  (/ (+ a b) 2))

(define (improve guess x)
  (avg guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))
      
(define (my-sqrt x)
  (sqrt-iter 1.0 x))

;; test
(my-sqrt 4)
(my-sqrt 2.0)
(my-sqrt 9)

