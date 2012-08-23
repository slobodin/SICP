;; Example 3.67

#lang racket

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

;;

(define (interleave s1 s2)
  (if (stream-empty? s1)
      s2
      (stream-cons (stream-first s1)
                   (interleave s2 (stream-rest s1)))))

(define (pairs s t)
  (stream-cons
   (list (stream-first s) (stream-first t))
   (interleave
    (interleave (stream-map (λ (x) (list (stream-first s) x))
                            (stream-rest t))
                (pairs (stream-rest s) (stream-rest t)))
    (stream-map (λ (x) (list x (stream-first t)))
                (stream-rest s)))))

(define S (pairs integers integers))

(display-stream-n S 150)