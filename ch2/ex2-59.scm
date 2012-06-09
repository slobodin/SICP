;; Example 2.59

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set2) set1)
         (union-set set1 (cdr set2)))
        (else (cons (car set2)
              (union-set set1 (cdr set2))))))

(define set1 (list 1 2 3 4 5))
(define set2 (list 3 4 5 6 7))

(element-of-set? 5 set1)
(adjoin-set 2 set2)
(intersection-set set1 set2)
(union-set set1 set2)