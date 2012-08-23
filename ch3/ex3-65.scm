;; Example 3.65

#lang racket

(require racket/stream)

;; for partial sums and scaling streams

(define (my-stream-map proc . argstreams)
  (if (stream-empty? (car argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply my-stream-map
              (cons proc (map stream-rest argstreams))))))

(define (add-streams s1 s2)
  (my-stream-map + s1 s2))

(define (partial-sums stream)
  (stream-cons (stream-first stream)
               (add-streams (partial-sums stream)
                            (stream-rest stream))))

;; display

(define (display-stream-n stream n)
  (if (<= n 0)
      'done
      (begin
        (display (stream-first stream))
        (newline)
        (display-stream-n (stream-rest stream) (- n 1)))))

;; euler transform

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (stream-cons (- s2 (/ (* (- s2 s1) (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-rest s)))))

(define (make-tableau transform s)
  (stream-cons s
               (make-tableau transform
                             (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-first
              (make-tableau transform s)))

;; ln

(define (ln-summands n)
  (stream-cons (/ 1.0 n)
               (stream-map - (ln-summands (+ n 1)))))

(define ln-stream (partial-sums (ln-summands 1)))

(display "--- ln 2 ---\n\n")
(display-stream-n ln-stream 10)

(display "\n--- ln 2 euler improved ---\n\n")
(display-stream-n (euler-transform ln-stream) 10)

(display "\n--- ln 2 euler improved improved ---\n\n")
(display-stream-n (accelerated-sequence euler-transform ln-stream) 10)