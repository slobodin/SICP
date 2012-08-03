
(define (my-assoc key records)
  (cond ((null? records) #f)
        ((equal? key (caar records)) (car records))
        (else (my-assoc key (cdr records)))))

(define (make-table)
  (let ((local-table (list '*table*)))
    
    (define (lookup key-1 key-2)
      (let ((subtable (my-assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (my-assoc key-2 (cdr subtable))))
              (if record
                  (cdr record)
                  #f))
            #f)))
    
    (define (insert! key-1 key-2 value)
      (let ((subtable (my-assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (my-assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)
    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc) insert!)
            (else (error "Undefined operation -- TABLE" m))))
    dispatch))