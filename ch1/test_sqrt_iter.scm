;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname test_sqrt_iter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
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

