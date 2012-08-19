#lang racket

;; it's fukken awesome

(require racket/stream)

(define (divisible? x y)
  (= (remainder x y) 0))

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define (sieve stream)
  (stream-cons 
   (stream-first stream)
   (sieve (stream-filter 
           (lambda (x) (not (divisible? x (stream-first stream))))
           (stream-rest stream)))))

(define primes (sieve (integers-starting-from 2)))

(stream-ref primes 50)