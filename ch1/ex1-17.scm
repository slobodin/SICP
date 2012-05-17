;; Example 1.17

(define (mul a b)
  (if (= b 0) 0
      (+ a (mul a (- b 1)))))

;(mul 2 5)
;(mul 4 5)
;(mul 3 15)

(define (double x)
  (* x 2))

(define (half x)
  (/ x 2))

(define (fast-mul a b)
  (cond ((= b 0) 0)
        ((even? b) (fast-mul (double a) (half b)))
        (else (+ 

(fast-mul 2 5)
(fast-mul 6 6)
(fast-mul 4 5)
(fast-mul 3 15)