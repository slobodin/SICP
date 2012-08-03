;; Example 3.26

;; node == ( ( pair key value ) left-ptr right-ptr )

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= (car x) (car (entry set))) set)
        ((< (car x) (car (entry set)))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> (car x) (car (entry set)))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define (make-table)
  (let ((local-table '()));; (list '*table* '() '())))
    
    (define (lookup key records)
      (cond ((null? records) #f)
            ((= key (car (entry records))) (entry records))
            ((< key (car (entry records))) (lookup key (left-branch records)))
            ((> key (car (entry records))) (lookup key (right-branch records)))))
    
    (define (insert! key value)
      (let ((record (lookup key local-table)))
        (if record
            (set-cdr! record value)
            (set! local-table (adjoin-set (cons key value) local-table)))))
    
    (define (get key)
      (lookup key local-table))
    
    (define (dispatch m)
      (cond ((eq? m 'get-proc) get)
            ((eq? m 'insert-proc) insert!)
            ((eq? m 'print) local-table)
            (else (error "Undefined operation -- TABLE" m))))
    dispatch))

(define table (make-table))
(define get (table 'get-proc))
(define put (table 'insert-proc))

(put 43 'a)
(put 42 'b)
(put 41 'c)
(put 67 'z)
(put 88 'e)

(table 'print)

(get 88)