;; Example 3.59

#lang racket

(require racket/stream)

;; accumulate stream n times

(define (fold-stream stream n)
  (if (<= n 0)
      0
      (+ (stream-first stream)
         (fold-stream (stream-rest stream) (- n 1)))))

(define (integrate-series stream)
  (define (iter str counter)
    (stream-cons (* (/ 1. counter) (stream-first str))
                 (iter (stream-rest str) (+ counter 1))))
  (iter stream 1))

(define exp-series
  (stream-cons 1 (integrate-series exp-series)))

(fold-stream exp-series 100)

(define cosine-series
  (stream-cons 1 (stream-map (lambda (x) (- x))
                             (integrate-series sine-series))))

(define sine-series
  (stream-cons 0 (integrate-series cosine-series)))