;; test 2d tables

(define (my-assoc key records)
  (cond ((null? records) #f)
        ((equal? key (caar records)) (car records))
        (else (my-assoc key (cdr records)))))

(define (lookup key-1 key-2 table)
  (let ((subtable (my-assoc key-1 (cdr table))))
    (if subtable
        (let ((record (my-assoc key-2 (cdr subtable))))
          (if record
              (cdr record)
              #f))
        #f)))

(define (insert! key-1 key-2 value table)
  (let ((subtable (my-assoc key-1 (cdr table))))
    (if subtable
        (let ((record (my-assoc key-2 (cdr subtable))))
          (if record
              (set-cdr! record value)
              (set-cdr! subtable
                        (cons (cons key-2 value)
                              (cdr subtable)))))
        (set-cdr! table
                  (cons (list key-1
                              (cons key-2 value))
                        (cdr table)))))
  'ok)

(define (make-table)
  (list '*table*))

(define table (make-table))

(insert! 'math '+ 43 table)
(insert! 'math '- 45 table)
(insert! 'math '* 42 table)

(insert! 'letters 'a 97 table)
(insert! 'letters 'b 98 table)

table

(insert! 'math '* 142 table)

table