(define x (list 'a 'b))
(define z1 (cons x x))

(define z2 (cons (list 'a 'b) (list 'a 'b)))

z1
z2

(define (set-to-wow! l)
  (set-car! (car l) 'wow)
  l)

(set-to-wow! z1)
(set-to-wow! z2)