;; In order to use `parallel-execute' you need this:
;; http://planet.racket-lang.org/display.ss?package=sicp-concurrency.plt&owner=dyoo
;; install package, reboot drracket, change language to "SICP Concurrency language"

;; 121 101 11 100 110

(define (test)
  (define (iter count)
    (define x 10)
    (if (<= count 0)
        #t
        (begin (parallel-execute (lambda () (set! x (* x x)))
                                 (lambda () (set! x (+ x 1))))
               (display x)
               (newline)
               (iter (- count 1)))))
  (iter 40))

(test)

(define x 10)
(define s (make-serializer))
(parallel-execute (s (lambda () (set! x (* x x))))
                  (s (lambda () (set! x (+ x 1)))))

x

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
            ((eq? m 'balance) balance)
            (else (error "Unknown request" m))))
    dispatch))