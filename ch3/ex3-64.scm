;; Example 3.64

#lang racket

(define (square x) (* x x))

(define (average a b)
  (/ (+ a b) 2))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(require racket/stream)

(define (sqrt-stream x)
  (define guesses
    (stream-cons 1.0
                 (stream-map (lambda (guess) (sqrt-improve guess x))
                             guesses)))
  guesses)

(define (stream-limit stream tol)
  (let ((s1 (stream-first stream))
        (s2 (stream-first (stream-rest stream))))
    (if (< (abs (- s1 s2)) tol)
        s2
        (stream-limit (stream-rest (stream-rest stream)) tol))))

(define (my-sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(my-sqrt 2 1)
(my-sqrt 2 0.5)
(my-sqrt 2 0.0000001)