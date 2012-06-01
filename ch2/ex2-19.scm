;; Example 2.19

;; 1 2 3 4 5
;; 50 25 10 5 1
(define (first-denomination kinds-of-coins)
  (car kinds-of-coins))

(define (except-first-denomination coins)
  (cdr coins))

(define (no-more? coins)
  (null? coins))

;; 
(define (count-change amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else (+ (count-change amount 
                               (except-first-denomination coin-values))
                 (count-change (- amount 
                                  (first-denomination coin-values)) 
                               coin-values)))))

(define us-coins (list 1 5 10 25 50))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(count-change 100 us-coins)
(count-change 10 us-coins)
(count-change 11 us-coins)
(count-change 100 uk-coins)