(define (scale-list items factor)
  (if (null? items)
      null
      (cons (* (car items) factor)
            (scale-list (cdr items) factor))))

(scale-list (list 1 2 3 4 5) 5)

(define (my-map proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (my-map proc (cdr items)))))

(my-map abs (list -1 -2 -3 4 5))
(my-map (lambda (x) (* x x)) (list 1 2 3 4 5))

(define (scale-tree tree factor)
  (cond ((null? tree) null)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))

(define x (list (list 1 2) (list 3 4)))
x

(scale-tree x 2)

(define (scale-tree-2 tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (scale-tree-2 sub-tree factor)
             (* sub-tree factor)))
       tree))

(scale-tree-2 x 2)