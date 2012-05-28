;; Example 1.37.a

;; recursive
(define (cont-frac n d k)
  (define (loop i)
    (if (= i k) (/ (n i) (d i))
        (/ (n i) (+ (d i) (loop (+ i 1))))))
  (loop 0))

(define one-div-phi (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 10))

(* one-div-phi 1.6180327868852458)