;; Example 2.54

(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))

(define (my-equal? lst1 lst2)
  (cond ((and (null? lst1) (null? lst2)) #t)
        ((and (symbol? lst1) (symbol? lst2))
         (eq? lst1 lst2))
        ((and (list? lst1) (list? lst2))
         (and (my-equal? (car lst1) (car lst2))
              (my-equal? (cdr lst1) (cdr lst2))))))

(my-equal? '(this is a list) '(this is a list))
(my-equal? '(this is a list) '(this (is a) list))
(my-equal? '(this (is a) list) '(this (is a) list))