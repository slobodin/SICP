(define (make-simplified-withdraw balance)
  (λ (amount)
    (set! balance (- balance amount))
    balance))

(define W (make-simplified-withdraw 25))

(W 10)
(W 20)

(define (make-decrementer balance)
  (λ (amount)
    (- balance amount)))

(define D (make-decrementer 25))

(D 10)
(D 5)

(define D1 (make-decrementer 25))
(define D2 (make-decrementer 25))