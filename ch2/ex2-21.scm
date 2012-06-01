;; Example 2.21

(define (square-list items)
  (if (null? items)
      null
      (cons ((lambda (x) (* x x)) (car items))
            (square-list (cdr items)))))

(square-list (list 2 4 6 8 16))

(define (square-list-2 items)
  (map (lambda (x) (* x x)) items))

(square-list-2 (list 2 4 6 8 16))