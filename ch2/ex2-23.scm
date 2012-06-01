;; Example 2.23

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

(define (my-foreach proc items)
  (define (iter items)
    (cond ((null? items) #t)
          (else
           (proc (car items))
           (iter (cdr items)))))
  (iter items))

(my-foreach (lambda (x) (newline) (display x))
            (list 57 321 88))