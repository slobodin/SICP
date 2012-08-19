#lang racket

;; Example 3.51

(require racket/stream)

(define (my-stream-ref s n)
  (if (= n 0)
      (stream-first s)
      (my-stream-ref (stream-rest s) (- n 1))))

(define (my-stream-map proc s)
  (if (stream-empty? s)
      empty-stream
      (stream-cons (proc (stream-first s))
                   (my-stream-map proc (stream-rest s)))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      empty-stream
      (stream-cons
       low
       (stream-enumerate-interval (+ low 1) high))))

(define (display-line x)
  (newline)
  (display x))

(define (show x)
  (display-line x)
  x)

(define x (my-stream-map show (stream-enumerate-interval 0 10)))

;(my-stream-ref x 5)
;(my-stream-ref x 7)