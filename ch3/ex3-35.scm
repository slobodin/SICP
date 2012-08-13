;; Example 3.35

#lang racket

(require "test_constraints.scm")

(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
        (if (< (get-value b) 0)
            (error "Square less than zero -- SQUARER" (get-value b))
            (set-value! a (sqrt (get-value b)) me))
        (if (has-value? a)
            (set-value! b (* (get-value a) (get-value a)) me)
            (newline)))) ;; stub
  
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me)
    (process-new-value))
  
  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
           (error "Unknown request" request))))
  
  (connect a me)
  (connect b me)
  me)

(define A (make-connector))
(define B (make-connector))
(squarer A B)

(probe "resa" A)
(probe "resb" B)

(set-value! A 14 'user)
(forget-value! A 'user)
(set-value! B 49 'user)