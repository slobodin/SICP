;; Example 2.27

(define x (list (list 1 2) (list 3 4)))
x

(define (my-reverse lst)
  (define (iter l result)
    (if (null? l)
        result
        (iter (cdr l) 
              (cons (car l) result))))
  (iter lst ()))

(my-reverse x)

;; When constructing reverse list from 
;; (car list-on-this-iteration) and result
;; we need to check, whether list-on-this-iteration is list
;; if true - deep-reverse it.
(define (deep-reverse items)
  (define (iter l result)
    (if (null? l)
        result
        (iter (cdr l)
              (cons (if (list? (car l)) (deep-reverse (car l))
                        (car l))
                    result))))
  (iter items ()))

(deep-reverse x)
                  