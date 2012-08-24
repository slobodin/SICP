;; Example 3.76

#lang racket

(require racket/stream)

(define (my-stream-map proc . argstreams)
  (if (stream-empty? (car argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply my-stream-map
              (cons proc (map stream-rest argstreams))))))

(define (smooth stream)
  (my-stream-map (λ (x1 x2) (/ (+ x1 x2) 2))
                 (stream-cons 0 stream)
                 stream))