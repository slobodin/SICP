#lang racket

;; Example 4.4

;; not sure need testing

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        
        ((and? exp) (eval-and (and-operands exp) env))
        ((or? exp) (eval-or (or-operands exp) env))
        
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)                 ;; apply procedure (proc, args)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type -- EVAL" exp))))

;; and

(define (and? exp) (tagged-list? exp 'and))
(define (and-operands exp) (cdr exp))
(define (eval-and exp env)
  (cond ((null? exp) 'true)
        ((false? (eval (car exp))) 'false)
        (else (eval-and (cdr exp) env))))

;; or

(define (or? exp) (tagged-list? exp 'or))
(define (or-operands exp) (cdr exp))
(define (eval-or exp env)
  (cond ((true? (eval (car exp))) 'true)
        ((null? exp) 'false)
        (else (eval-or (cdr exp) env))))