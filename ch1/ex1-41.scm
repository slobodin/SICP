;; Example 1.41

(define (inc n)
  (+ n 1))

(define (double f)
  (lambda (x) (f (f x))))

((double inc) 5)

;; I think it's is 5+16=21
;; Let's try:

(((double (double double)) inc) 5)

;; that's it