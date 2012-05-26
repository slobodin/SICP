;; Example 1.29

(define (simpson-integral f a b n)
  
  (define (mult i)
    (cond ((= i 0) 1)
          ((= i n) 1)
          ((even? i) 2)
          (else 4)))

  (define h (/ (- b a) n))
  
  (define (iter i sum)
    (if (> i n)
        (* sum (/ h 3.0))
        (iter (+ i 1) (+ sum (* (f (+ a (* i h))) (mult i))))))
  
  (iter -1 0))

(define (cube a)
  (* a a a))

(simpson-integral cube 0 1 1000)
;; => 0.24999999999866668
(simpson-integral cube 0 1 100)
;; => 0.24999998666666667

;; Functions from above:
;; => 0.24998750000000042 (e = 0.1)
;; => 0.249999875000001 (e = 0.001)