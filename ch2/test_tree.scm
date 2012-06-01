(define x (cons (list 1 2) (list 3 4)))

(define (lenght items)
  (if (null? items)
      0
      (+ 1 (lenght (cdr items)))))

(define (count-leaves tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) 1)
        (else (+ (count-leaves (car tree))
                 (count-leaves (cdr tree))))))

(lenght x)
(list x x)
(lenght (list x x))

(count-leaves x)
(count-leaves (list x x))