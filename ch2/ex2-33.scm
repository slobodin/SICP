;; Example 2.33

(define (square a)
  (* a a))

(define (filter predicate seq)
  (cond ((null? seq) null)
        ((predicate (car seq))
         (cons (car seq) (filter predicate (cdr seq))))
        (else (filter predicate (cdr seq)))))

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low
            (enumerate-interval (+ low 1) high))))

;; 1.
(define (my-map p seq)
  (accumulate (lambda (x y) (cons (p x) y))
              null
              seq))

(my-map square (list 2 3 4 5))

;; 2.
(define (my-append seq1 seq2)
  (accumulate cons
              seq2
              seq1))

(my-append (list 2 3 4 5) (list 6 7 8 9))

;; 3.
(define (lenght seq)
  (accumulate (lambda (x y) (+ 1 y))
              0
              seq))

(lenght (list 2 3 4 5))