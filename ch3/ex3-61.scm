;; Example 3.61

#lang racket

;; scale a stream

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

;; require for add streams

(define (my-stream-map proc . argstreams)
  (if (stream-empty? (car argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply my-stream-map
              (cons proc (map stream-rest argstreams))))))

(define (add-streams s1 s2)
  (my-stream-map + s1 s2))

;; from 3.59

(define (integrate-series stream)
  (define (iter str counter)
    (stream-cons (* (/ 1. counter) (stream-first str))
                 (iter (stream-rest str) (+ counter 1))))
  (iter stream 1))

(define cosine-series
  (stream-cons 1 (stream-map (lambda (x) (- x))
                             (integrate-series sine-series))))

(define sine-series
  (stream-cons 0 (integrate-series cosine-series)))

;; from 3.60

(define (mul-series s1 s2)
  (stream-cons (* (stream-first s1) (stream-first s2))
               (add-streams (scale-stream (stream-rest s2) (stream-first s1))
                            (mul-series (stream-rest s1) s2))))

;; 3.61

(define (invert-unit-series S)
  (define res (stream-cons 1 (stream-map (λ (x) (- x))
                                         (mul-series (stream-rest S) res))))
  res)

;; test

(define (fold-stream stream n)
  (if (<= n 0)
      0
      (+ (stream-first stream)
         (fold-stream (stream-rest stream) (- n 1)))))

(define exp-series
  (stream-cons 1 (integrate-series exp-series)))

(define one-div-e (invert-unit-series exp-series))

(fold-stream one-div-e 10)