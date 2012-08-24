;; Example 3.69

#lang racket

(require racket/stream)

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
   (list (stream-first s) (stream-first t))
   (interleave
    (stream-map (lambda (x) (list (stream-first s)
                                  x))
                (stream-rest t))
    (pairs (stream-rest s) (stream-rest t)))))

(define (triples s t u)
  (stream-cons
   (list (stream-first s) (stream-first t) (stream-first u))
   (interleave
    (stream-map (λ (x) (append (list (stream-first s)) x))
                (stream-rest (pairs t u)))
    (triples (stream-rest s)
             (stream-rest t)
             (stream-rest u)))))

(define phy
  (stream-filter (λ (triple)
                   (let ((i (car triple))
                         (j (cadr triple))
                         (k (caddr triple)))
                     (= (* k k) (+ (* i i) (* j j)))))
                 (triples integers integers integers)))

(display-stream-n phy 5)