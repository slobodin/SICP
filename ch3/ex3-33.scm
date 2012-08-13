;; Example 3.33

#lang racket

(require "test_constraints.scm")

(define (averager a1 a2 res)
  (let ((u (make-connector))
        (half (make-connector)))
    (adder a1 a2 u)
    (multiplier u half res)
    (constant 0.5 half)
    'ok))

(define A (make-connector))
(define B (make-connector))
(define C (make-connector))
(averager A B C)

(probe "res" C)

(set-value! A 14 'user)
(set-value! B 15 'user)