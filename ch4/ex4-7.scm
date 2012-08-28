#lang racket

;; Example 4.7

;; Need testing.

(define (eval exp env)
  (cond (...)
        ((let*? exp) (eval (let*->nested-lets (cdr exp)) env))
        (...)))

;; let* stuff

(define (let*? exp)
  (tagged-list? exp 'let*))

(define (let*-body exp) (cdr exp))
(define (let*-vars-and-exps exp) (car exp))

(define (let*->nested-lets exp)
  (define (helper var-exps body)
    (if (null? (cdr var-exps))
        (cons 'let (cons var-exps body))    ;; final let
        (list 'let (list (car var-exps))
              (helper (cdr var-exps) body))))
  (helper (let*-vars-and-exps exp) (let*-body exp)))


;; random test stuff

(define initial '(let ((a 2)
                       (b 3)
                       (c (foo 42)))
                   (body 2)))

initial

(define vars-exps (cadr initial))
(define body (cddr initial))

vars-exps
body

(define last-var-exp (cddr vars-exps))
(cons 'let (cons last-var-exp body))

(display "***")

(car vars-exps)

(list 'let (list (car vars-exps))
      (cons 'let (cons last-var-exp body)))