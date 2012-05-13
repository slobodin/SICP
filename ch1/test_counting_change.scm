;; Counting change.

;; 1 2 3 4 5
;; 50 25 10 5 1
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

;; 
(define (count-change amount num)
  (cond ((= amount 0) 1)
        ((< amount 0) 0)
        ((= num 0) 0)
        (else (+ (count-change amount (- num 1))
                 (count-change (- amount (first-denomination num)) num)))))

(count-change 100 5)
(count-change 10 2)
 