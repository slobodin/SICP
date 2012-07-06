;; Example 3.4

(define (make-account balance password)
  (define num-attempts 0)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  
  (define (dispatch pwd m)
    (if (eq? pwd password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-ACCOUNT" m)))
        (if (>= num-attempts 7)
            (call-the-cops)
            (begin (set! num-attempts (+ num-attempts 1))
                   (λ (stub)
                   (display "Incorrect password!\n"))))))
  
  (define (call-the-cops)
    (error "Wait the police"))
  
  dispatch)

(define acc (make-account 42 'root))
((acc 'root 'withdraw) 33)
((acc 'password 'withdraw) 10)
((acc 'root 'withdraw) 2)

((acc 'password 'withdraw) 10)
((acc 'password 'withdraw) 10)
((acc 'password 'withdraw) 10)
((acc 'password 'withdraw) 10)
((acc 'password 'withdraw) 10)
((acc 'password 'withdraw) 10)
((acc 'password 'withdraw) 10)
((acc 'password 'withdraw) 10)