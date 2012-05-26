;; Example 1.32.b

;; iterative

(define (product func a next b)
  (define (iter sum curr-a)
    (if (> curr-a b)
        sum
        (iter (* sum (func curr-a)) (next curr-a))))
  (iter 1 a))

(define (accumulate combiner null-value func a next b)
  (define (iter result curr-a)
    (if (> curr-a b)
        result
        (iter (combiner result (func curr-a)) (next curr-a))))
  (iter null-value a))

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