;; Example 2.61

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (car set)) #t)
        ((< x (car set)) #f)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond ((= x1 x2) (cons x1 (intersection-set (cdr set1) (cdr set2))))
              ((< x1 x2) (intersection-set (cdr set1) set2))
              ((< x2 x1) (intersection-set set1 (cdr set2)))))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define set1 (list 1 2 3 4 5))
(define set2 (list 3 4 5 6 7))

(element-of-set? 5 set1)
(intersection-set set1 set2)
(adjoin-set 12 set1)
(adjoin-set 2 set1)