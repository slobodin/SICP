#lang racket

(require racket/stream)

;; display

(define (display-stream-n stream n)
  (if (<= n 0)
      'done
      (begin
        (display (stream-first stream))
        (newline)
        (display-stream-n (stream-rest stream) (- n 1)))))

;; integers

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

;; pairs i <= j

(define (interleave s1 s2)
  (if (stream-empty? s1)
      s2
      (stream-cons (stream-first s1)
                   (interleave s2 (stream-rest s1)))))

(define (pairs s t)
  (stream-cons
   (list (stream-first s) (stream-first t))  ;; S0, T0
   (interleave
    (stream-map (lambda (x) (list (stream-first s)  ;; S0
                                  x)) ;; S0, Ti
                (stream-rest t))
    (pairs (stream-rest s) (stream-rest t))))) ;; the same recursively

(define S (pairs integers integers))

(display-stream-n S 150)