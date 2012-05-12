;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ex1-6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;; Example 1.6

(define (new-if pred then-clause else-clause)
  (cond (pred then-clause)
        (else else-clause)))

(define (square x)
  (* x x))

(define (avg a b)
  (/ (+ a b) 2))

(define (improve guess x)
  (avg guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))
      
(define (my-sqrt x)
  (sqrt-iter 1.0 x))

;; (my-sqrt 2) -- forever loop
;; We need first evaluate pred, but new-if evaluates arguments