;; Example 2.17

(define (last-pair lst)
  (if (null? (cdr lst))
      (list (car lst))
      (last-pair (cdr lst))))

(last-pair (list 23 72 149 34))