;; Example 1.20

(define (my-gcd a b)
  (cond ((= b 0) a)
        (else (my-gcd b (remainder a b)))))

(my-gcd 206 40)

;; normal order
;; (my-gcd 206 40)
;; 1. (cond ((= 40 0) 206)
;;          (else (my-gcd 40 (remainder 206 40))))
;; 2. (cond ((= 40 0) 206)
;;          (else (cond ((= (remainder 206 40) 0))
;;                      (else (my-gcd (remainder 206 40) (remainder 40 (remainder 206 40)))
;; ........... bla bla bla


;; applicative order
;; 1. (my-gcd 206 40)
;; 2. (cond ((= 40 0) 206)
;;          (else (my-gcd 40 6)))
;; 3. (my-gcd 40 6)
;; ........... bla bla bla