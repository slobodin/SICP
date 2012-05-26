;; Example 1.32.a

;; recursive
(define (accumulate combiner null-value func a next b)
  (if (> a b)
      null-value
      (combiner (func a) (accumulate combiner null-value func (next a) next b))))

;; sum using accumulate
(define (sum term a next b)
  (accumulate + 0 term a next b))

;; some tests for accumulate and sum

(define (pi-sum a b)
  (define (term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum term a pi-next b))

(* 8 (pi-sum 1 1000))

;; product using accumulate
(define (product term a next b)
  (accumulate * 1 term a next b))

;; tests for product with accumulate
(define (square n)
  (* n n))

(define (pi-series b)  ;; start from 2 and 3
  (define (pi-next n)
    (+ n 2))
  (define (func n)
    (/ (* (- n 1) (+ n 1)) (square n)))
  (product func 3.0 pi-next b))

;; find pi
(* 4 (pi-series 1000))