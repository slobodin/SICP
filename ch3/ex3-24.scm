;; Example 3.24

(define (eps-equal? a b)
  (< (abs (- a b)) 0.1))

(define (my-assoc key records equal-func)
  (cond ((null? records) #f)
        ((equal-func key (caar records)) (car records))
        (else (my-assoc key (cdr records) equal-func))))

(define (make-table same-key?)
  (let ((local-table (list '*table*)))
    
    (define (lookup key-1 key-2)
      (let ((subtable (my-assoc key-1 (cdr local-table) equal?)))
        (if subtable
            (let ((record (my-assoc key-2 (cdr subtable) same-key?)))
              (if record
                  (cdr record)
                  #f))
            #f)))
    
    (define (insert! key-1 key-2 value)
      (let ((subtable (my-assoc key-1 (cdr local-table) equal?)))
        (if subtable
            (let ((record (my-assoc key-2 (cdr subtable) same-key?)))
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
            ((eq? m 'print) local-table)
            (else (error "Undefined operation -- TABLE" m))))
    dispatch))

(define table (make-table eps-equal?))
(define get (table 'lookup-proc))
(define put (table 'insert-proc))

(put 'math '5.43 43)
(put 'math '6.43 45)
(put 'math '7.43 42)

(put 'letters '8.43 97)
(put 'letters '9.43 98)

(table 'print)

(put 'math '7.42 142)

(table 'print)