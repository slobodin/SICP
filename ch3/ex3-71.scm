;; Example 3.71

#lang racket

;; dependencies

(define (cube x) (* x x x))

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

;; 3.71

(define (ramanujan-numbers)
  (define (weight pair)
    (+ (cube (car pair))
       (cube (cadr pair))))
  
  (define ram-pairs (weighted-pairs integers integers weight))
  
  (define (iter pairs)
    (let ((w1 (weight (stream-first pairs)))
          (w2 (weight (stream-first (stream-rest pairs)))))
      (if (= w1 w2)
          (stream-cons w1 (iter (stream-rest (stream-rest pairs))))
          (iter (stream-rest pairs)))))
  (iter ram-pairs))

(stream-ref (ramanujan-numbers) 0)