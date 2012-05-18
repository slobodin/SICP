;; Test GCD

(define (my-gcd a b)
  (cond ((= b 0) a)
        (else (my-gcd b (remainder a b)))))

(my-gcd 206 40)
(my-gcd 24 88)
(my-gcd 2 7)