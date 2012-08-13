#lang racket

(require "test_constraints.scm")
  
(define (celsius-fahrenheit-converter c f)
  (let ((u (make-connector))
        (v (make-connector))
        (w (make-connector))
        (x (make-connector))
        (y (make-connector)))
    (multiplier c w u)
    (multiplier v x u)
    (adder v y f)
    (constant 9 w)
    (constant 5 x)
    (constant 32 y)
    'ok))

(define C (make-connector))
(define F (make-connector))
(celsius-fahrenheit-converter C F)

(probe "Celsium" C)
(probe "Fahrenheit" F)

(set-value! C 25 'user)
(forget-value! C 'user)
(set-value! F -150. 'user)