;; Example 2.47

(define (make-vect x y)
  (cons x y))

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

(define fr (make-frame (make-vect 0 0) (make-vect 1 1) (make-vect 2 2)))
fr
(origin-frame fr)
(edge1-frame fr)
(edge2-frame fr)

(display "--- Version 2 --- \n")

(define (make-frame-2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame-2 frame)
  (car frame))

(define (edge1-frame-2 frame)
  (cadr frame))

(define (edge2-frame-2 frame)
  (cddr frame))

(define fr (make-frame-2 (make-vect 5 5) (make-vect 6 6) (make-vect 7 7)))
fr
(origin-frame-2 fr)
(edge1-frame-2 fr)
(edge2-frame-2 fr)