#lang racket

;; Example 4.6

;; Tested. Merged in interpreter.

(define (eval exp env)
  (cond (...)
        ((let? exp) (eval (let->combination (cdr exp)) env))
        (...)))

;; let stuff

(define (let? exp)
  (tagged-list? exp 'let))

(define (let-body exp) (cdr exp))
(define (let-vars-and-exps exp) (car exp))

;; should use foldr with cons '() and filter. But.... let's use simple scheme to make simple scheme interpreter
(define (let-vars exp)
  (if (null? exp)
      '()
      (cons (caar exp) (let-vars (cdr exp)))))

(define (let-exps exp)
  (if (null? exp)
      '()
      (cons (cadar exp) (let-exps (cdr exp)))))

(define (let->combination exp)
  (cons (make-lambda (let-vars (let-vars-and-exps exp)) (let-body exp))
        (let-exps (let-vars-and-exps exp))))
