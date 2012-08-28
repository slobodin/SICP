#lang racket

;; Example 4.9

;; Need testing.

;; (while (exp)
;;   (body)))

(define (eval exp env)
  (cond (...)
        ((while? exp) (eval-while exp env))
        (...)))

(define (while? exp) (tagged-list? exp 'while))
(define (while-cond exp) (cadr exp))
(define (while-body exp) (caddr exp))

(define (while->combination exp)
  (sequence->exp
   (list (list 'define
               (list 'loop)    ;; (define (loop) (if () (begin (body) (loop)) 'done))
               (make-if (while-cond exp)
                        (sequence->exp (list (while-body)
                                             (list 'loop)))
                        'done))
         (list 'loop))))
