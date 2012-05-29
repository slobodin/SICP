;; Example 1.38

;; recursive
(define (cont-frac n d k)
  (define (loop i)
    (if (= i k) (/ (n i) (d i))
        (/ (n i) (+ (d i) (loop (+ i 1))))))
  (loop 0))

(define (next-d i)
  (if (= (remainder i 3) 1)
      (* 2 (+ (quotient i 3) 1))
      1))

(define find-e-minus-two (cont-frac (lambda (i) 1.0)
                                    next-d
                                    10))

(define (e) (+ find-e-minus-two 2.0))

(e)