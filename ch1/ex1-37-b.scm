;; Example 1.37.b

;; iterative
(define (cont-frac n d k)
  (define (loop i result)
    (if (= i 0) result
        (loop (- i 1) (/ (n i) (+ (d i) result)))))
  (loop k (d k)))

(define one-div-phi (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 10))

(* one-div-phi 1.6180327868852458)