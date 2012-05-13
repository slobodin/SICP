;; Example 1.11

;; f(n) = n, n < 3
;; f(n) = f(n-1)+f(n-2)+f(n-3), n >= 3

;; recursive
(define (fr n)
  (if (< n 3) n
      (+ (fr (- n 1)) (fr (- n 2)) (fr (- n 3)))))

(fr 1)
(fr 2)
(fr 3)
(fr 4)
(fr 5)
(fr 6)
(fr 7)

;; iterate
(define (fi n)
  (define (iter a b c counter)
    (if (= counter n) a
        (iter b c (+ a b c) (+ counter 1))))
  
  (iter 1 2 3 1))

(fi 1)
(fi 2)
(fi 3)
(fi 4)
(fi 5)
(fi 6)
(fi 7)