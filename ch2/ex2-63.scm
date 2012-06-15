(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (entry set)) #t)
        ((< x (entry set)) (element-of-set? x (left-branch set)))
        (else (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define t (make-tree 2 '() '()))
(define t1 (adjoin-set 5 t))
(define t2 (adjoin-set 3 t1))
(define t3 (adjoin-set 1 t2))
t3

(define (tree->list-1 tree)
  (if (null? tree) '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(tree->list-1 t3)

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree) result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(tree->list-2 t3)

(define test-tree (make-tree 7 
                             (make-tree 3 (make-tree 1 '() '()) (make-tree 5 ' ()'()))
                             (make-tree 9 '() (make-tree 11 '() '()))))
(tree->list-1 test-tree)
(tree->list-2 test-tree)

(define test-tree-2 (make-tree 3
                               (make-tree 1 '() '())
                               (make-tree 7 (make-tree 5 '() '()) (make-tree 9 '() 
                                                                             (make-tree 11 '() '())))))

(tree->list-1 test-tree-2)
(tree->list-2 test-tree-2)

(define test-tree-3 (make-tree 5 (make-tree 3 (make-tree 1 '() '()) '())
                               (make-tree 9 (make-tree 7 '() '())
                                          (make-tree 11 '() '()))))

(tree->list-1 test-tree-3)
(tree->list-2 test-tree-3)

;; 1 ver - need to append + cons
;; 2 ver - only cons