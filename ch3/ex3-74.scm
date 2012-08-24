;; Example 3.74

#lang racket

(require racket/stream)

(define (my-stream-map proc . argstreams)
  (if (stream-empty? (car argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply my-stream-map
              (cons proc (map stream-rest argstreams))))))

(define zero-crossings
  (my-stream-map sign-change-detector sense-data (stream-cons 0 sense-data)))