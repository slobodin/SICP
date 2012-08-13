#lang racket

(require "test_constraints.scm")

(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
        (if (< (get-value b) 0)
            (error "Square less than zero -- SQUARER" (get-value b))
            alter)
        alter2))
  
  (define (process-forget-value)
    ...)
  
  (define (me request)
    ...)
  
  ...
  me)