;; Example 3.58

#lang racket

(require racket/stream)

(define (expand num den radix)
  (stream-cons
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

(define s1 (expand 1 7 10))

;; 1 4 2 8 5 7 
;; 0.142857142...