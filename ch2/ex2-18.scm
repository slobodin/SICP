;; Example 2.18

(define (my-reverse lst)
  (define (iter l result)
    (if (null? l)
        result
        (iter (cdr l) 
              (cons (car l) result))))
  (iter lst ()))

(my-reverse (list 1 2 3 4 5))