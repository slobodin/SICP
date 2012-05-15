;; Example 1.16.

(define (square x)
  (* x x))

(define (fast-exp-iter b n)
  (define (iter a b n)
    (cond ((zero? n) a)
          ((even? n) (iter a (square b) (/ n 2)))
          (else (iter (* a b) b (- n 1)))))
  
  (iter 1 b n))

(fast-exp-iter 2 2)
(fast-exp-iter 2 3)
(fast-exp-iter 2 4)
(fast-exp-iter 2 5)
(fast-exp-iter 2 6)
(fast-exp-iter 2 7)
(fast-exp-iter 2 16)