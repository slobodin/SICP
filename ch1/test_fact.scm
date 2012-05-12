;; Factorial.

;; linear-recursive
(define (factorial n)
  (if (= 0 n)
      1
      (* n (factorial (- n 1)))))

;;
(factorial 5)
(factorial 3)

;; linear-iterative
(define (fact-iter n)
  (define (fact-iter-detail prod counter)
    (if (> counter n)
        prod
        (fact-iter-detail (* prod counter)
                          (+ counter 1))))
  (fact-iter-detail 1 1))

(fact-iter 5)
(fact-iter 3)
  