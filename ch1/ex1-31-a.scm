;; Example 1.31.a

;; linear-recursive function
(define (product func a next b)
  (if (> a b)
      1
      (* (func a) (product func (next a) next b))))

(define (identity x) x)
(define (inc n) (+ n 1))

(define (factorial n)
  (product identity 1 inc n))

(factorial 1)
(factorial 2)
(factorial 3)
(factorial 4)
(factorial 5)
(factorial 6)

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