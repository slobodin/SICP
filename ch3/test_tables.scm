;; test tables

(define (lookup key table)
  (let ((record (my-assoc key (cdr table))))
    (if record
        (cdr record)
        #f)))

(define (my-assoc key records)
  (cond ((null? records) #f)
        ((equal? key (caar records)) (car records))
        (else (my-assoc key (cdr records)))))

(define (insert! key value table)
  (let ((record (my-assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons key value) (cdr table))))))

(define (make-table)
  (list '*table*))

(define table (make-table))

(insert! 'a 1 table)
(insert! 'b 2 table)
(insert! 'c 3 table)

table

(insert! 'c 4 table)

table

(lookup 'b table)