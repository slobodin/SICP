#lang racket

(require racket/stream)

;; Example 3.50

(define (my-stream-map proc . argstreams)
  (if (stream-empty? (car argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply my-stream-map
              (cons proc (map stream-rest argstreams))))))

(stream-first (my-stream-map + (list 1 2 3) (list 2 3 4) (list 3 4 5)))