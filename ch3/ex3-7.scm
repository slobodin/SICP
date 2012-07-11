;; Example 3.7

(define (make-account balance password)
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
              ((eq? m 'joint) #t)
              (else (error "Unknown request -- MAKE-ACCOUNT" m)))
        (λ (stub) (display "Incorrect password\n"))))
  
  dispatch)

(define acc (make-account 42 'root))
((acc 'root 'withdraw) 33)
((acc 'password 'withdraw) 10)
((acc 'root 'withdraw) 2)

(define (make-joint account origin-pwd new-pwd)
  (if (account 'origin-pwd 'joint)
      (λ (pwd m)
        (if (eq? pwd new-pwd)
            (account origin-pwd m)
            (account pwd m)))))

(define paul-acc (make-joint acc 'root 'rosebud))

((paul-acc 'rosebud 'withdraw) 5)
((paul-acc 'rosebud1 'withdraw) 5)
((paul-acc 'rosebud 'deposit) 500)
((acc 'root 'withdraw) 400)
((paul-acc 'rosebud 'withdraw) 50)