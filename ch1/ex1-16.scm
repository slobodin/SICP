;; Example 1.16.

;; TEST NOT WORKING PROPERLY
(define (fast-exp b n)
  (define (iter a counter)
    (if (= counter 0)
        a
        (iter (* a b) (- counter 1))))
  (iter 1 n))


(fast-exp 2 5)