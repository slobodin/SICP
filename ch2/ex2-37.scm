;; Example 2.37

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define v (list 1 2 3 4))
(define w (list 5 6 7 8))
(define m (list (list 1 2 3 4)
                (list 5 6 7 8)
                (list 9 1 2 3)
                (list 3 4 5 1)))

;; Dot product

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(dot-product v w)

;; Matrix * vector:
;; ( 1 2 3 )   ( 1 )
;; ( 5 6 7 ) * ( 2 )
;; ( 9 1 2 )   ( 3 )

(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product row v)) m))

(matrix-*-vector m v)

;; Transpose
(define (transpose mat)
  (accumulate-n cons () mat))

(transpose m)

;; Matrix * Matrix

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (map (lambda (col)
                              (dot-product col row))
                            cols))
         m)))

(matrix-*-matrix m m)