#lang racket

;; Example 3.55

(require racket/stream)

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (my-stream-map proc . argstreams)
  (if (stream-empty? (car argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply my-stream-map
              (cons proc (map stream-rest argstreams))))))

(define (add-streams s1 s2)
  (my-stream-map + s1 s2))

;; s0, s0+s1, s0+s1+s2, ...

(define (partial-sums stream)
  (stream-cons (stream-first stream)
               (add-streams (partial-sums stream)
                            (stream-rest stream))))

(define int-partial-sums (partial-sums integers))

(stream-ref int-partial-sums 1)
(stream-ref int-partial-sums 2)
(stream-ref int-partial-sums 3)