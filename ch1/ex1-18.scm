;; Example 1.18

(define (double x)
  (* x 2))
(define (half x)
  (/ x 2))

(define (russian-mult a b)
  (define (iter res a b)
    (cond ((= b 0) res)
          ((even? b) (iter (+ res (double a)) a (- b 2)))
          (else (iter (+ res a) a (- b 1)))))
  
  (iter 0 a b))

(russian-mult 2 5)
(russian-mult 10 15)