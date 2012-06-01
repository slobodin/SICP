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