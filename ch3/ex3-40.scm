;; Example 3.40

(define x 10)
(parallel-execute (lambda () (set! x (* x x)))
                  (lambda () (set! x (* x x x))))

;; 100
;; 1000
;; 1000000
;; 10000
;; 100000

;; serialized: 1000000