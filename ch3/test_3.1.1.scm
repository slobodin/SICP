(define balance 100)

(define (withdraw amount)
  (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficent funds"))

(withdraw 25)
(withdraw 25)
(withdraw 60)
(withdraw 15)

balance

(define (new-withdraw)
  (let ((balance 100))
    (λ (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))))

((new-withdraw) 40)

(display "MAKE WITHDRAW\n")

(define (make-withdraw balance)
  (λ (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))

(define W1 (make-withdraw 60))
(define W2 (make-withdraw 20))

(W1 40)
(W1 40)
(W2 5)
(W2 7)

(display "MAKE ACCOUNT\n")

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT" m))))
  
  dispatch)

(define account1 (make-account 42))
((account1 'withdraw) 33)
((account1 'withdraw) 10)
((account1 'deposit) 10)
((account1 'withdraw) 15)

(define account2 (make-account 142))
((account2 'withdraw) 33)