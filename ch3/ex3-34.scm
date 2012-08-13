;; Example 3.34

#lang racket

(require "test_constraints.scm")

(define (squarer a b)
  (multiplier a a b))

(define A (make-connector))
(define B (make-connector))
(squarer A B)

(probe "resa" A)
(probe "resb" B)

;(set-value! A 14 'user)
(set-value! B 15 'user)

;; set-val b
;; in multiplier:
;; in order to compute the equation x = y * z we need to know values of 2 variables
;; but there is only 1 (b).