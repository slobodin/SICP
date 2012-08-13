;; Example 3.37

#lang racket

(require "test_constraints.scm")

(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
    z))

(define (c* x y)
  (let ((z (make-connector)))
    (multiplier x y z)
    z))

(define (cv x)
  (let ((z (make-connector)))
    (constant x z)
    z))

(define (c/ x y)
  (let ((z (make-connector)))
    (multiplier y z x)
    z))

(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
          x)
      (cv 32)))

(define C (make-connector))
(define F (celsius-fahrenheit-converter C))

(probe "Celsium" C)
(probe "Fahrenheit" F)

(set-value! C 25 'user)
(forget-value! C 'user)
(set-value! F -150. 'user)