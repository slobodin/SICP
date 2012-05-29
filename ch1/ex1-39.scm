;; Example 1.39

;; recursive
(define (cont-frac-tan n d k)
  (define (loop i)
    (if (= i k) (/ (n i) (d i))
        (/ (n i) (- (d i) (loop (+ i 1))))))
  (loop 0))

(define (tan-cf x k)
  (define (next-n i)
    (if (= i 0) x
        (* x x)))
  (define (next-d i)
    (+ 1 (* i 2)))
  (cont-frac-tan next-n next-d k))

(tan-cf 0 10)
(tan-cf (/ 3.1415 4) 10)