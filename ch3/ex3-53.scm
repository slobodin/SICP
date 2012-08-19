#lang racket

;; Example 3.53

(require racket/stream)

(define (my-stream-map proc . argstreams)
  (if (stream-empty? (car argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply my-stream-map
              (cons proc (map stream-rest argstreams))))))

(define (add-streams s1 s2)
  (my-stream-map + s1 s2))

(define s (stream-cons 1 (add-streams s s)))

;; 1 1+1 2+2 4+4 8+8 16+16
;; 1 2 4 8 16 32 64

(stream-ref s 0)
(stream-ref s 1)
(stream-ref s 2)
(stream-ref s 3)
(stream-ref s 4)
(stream-ref s 5)