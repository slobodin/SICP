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

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

;; for newton's method

(define (square x) (* x x))

(define (average a b)
  (/ (+ a b) 2))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

;; display

(define (display-stream-n stream n)
  (if (<= n 0)
      'done
      (begin
        (display (stream-first stream))
        (newline)
        (display-stream-n (stream-rest stream) (- n 1)))))

;; test

(define (sqrt-stream x)
  (define guesses
    (stream-cons 1.0
                 (stream-map (lambda (guess) (sqrt-improve guess x))
                             guesses)))
  guesses)

(display "--- sqrt 2 ---\n\n")
(display-stream-n (sqrt-stream 2) 10)

(define (pi-summands n)
  (stream-cons (/ 1.0 n)
               (stream-map - (pi-summands (+ n 2)))))

(define pi-stream
  (scale-stream (partial-sums (pi-summands 1)) 4))

(display "\n--- pi ---\n\n")
(display-stream-n pi-stream 10)

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (stream-cons (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-rest s)))))

(display "\n--- pi euler improved ---\n\n")
(display-stream-n (euler-transform pi-stream) 10)

(define (make-tableau transform s)
  (stream-cons s
               (make-tableau transform
                             (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-first
              (make-tableau transform s)))

(display "\n--- pi euler improved improved ---\n\n")
(display-stream-n (accelerated-sequence euler-transform pi-stream) 10)
