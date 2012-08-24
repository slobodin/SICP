;; Example 3.70

#lang racket

(require racket/stream)

(define (display-stream-n stream n)
  (if (<= n 0)
      'done
      (begin
        (display (stream-first stream))
        (newline)
        (display-stream-n (stream-rest stream) (- n 1)))))

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (merge-weighted s1 s2 weight)
  (cond ((stream-empty? s1) s2)
        ((stream-empty? s2) s1)
        (else
         (let ((w1 (weight (stream-first s1)))
               (w2 (weight (stream-first s2))))
           (cond ((< w1 w2)
                  (stream-cons (stream-first s1) (merge-weighted (stream-rest s1) s2 weight)))
                 ((> w1 w2)
                  (stream-cons (stream-first s2) (merge-weighted s1 (stream-rest s2) weight)))
                 (else
                  (stream-cons (stream-first s1)
                               (merge-weighted (stream-rest s1)
                                               (stream-rest s2)
                                               weight))))))))

(define (interleave s1 s2)
  (if (stream-empty? s1)
      s2
      (stream-cons (stream-first s1)
                   (interleave s2 (stream-rest s1)))))

(define (weighted-pairs s t weight)
  (stream-cons
   (list (stream-first s) (stream-first t))
   (merge-weighted
    (stream-map (lambda (x) (list (stream-first s) 
                                  x))
                (stream-rest t))
    (weighted-pairs (stream-rest s) (stream-rest t) weight)
    weight)))

;; a)

(define a-stream (weighted-pairs integers integers
                                 (λ (pair) (+ (car pair) (cadr pair)))))

(display-stream-n a-stream 10)

;; b)

(define (divisible? x y)
  (= (remainder x y) 0))

(define hamming-integers
  (stream-filter (λ (x)
                   (and (not (divisible? x 2))
                        (not (divisible? x 3))
                        (not (divisible? x 5))))
                 integers))

(define b-stream (weighted-pairs hamming-integers hamming-integers
                                 (λ (pair) (+ (* 2 (car pair))
                                              (* 3 (cadr pair))
                                              (* 5 (car pair) (cadr pair))))))

(display-stream-n b-stream 20)