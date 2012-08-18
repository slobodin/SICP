;; Example 3.41

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds\n"))
  
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  
  (let ((protected (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (protected withdraw))
            ((eq? m 'deposit) (protected deposit))
            ((eq? m 'balance) ((protected (lambda () balance))))
            (else (error "Unknown request" m))))
    dispatch))

;; A = make-account

;; parallel:
;; balance = A.get-balance
;; A.make-withdraw

;; balance maybe wrong