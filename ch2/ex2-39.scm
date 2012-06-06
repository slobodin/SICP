;; Example 2.39

(define (fold-right op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (fold-right op initial (cdr seq)))))

;(fold-right + 0 (list 1 2 3 4 5))

(define (fold-left op initial seq)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial seq))

(define (reverse-1 seq)
  (fold-right (lambda (x y) 
                (append y (list x)))
              null
              seq))

(reverse-1 (list 1 2 3 4 5))

(define (reverse-2 seq)
  (fold-left (lambda (x y) 
               (append (list y) x))
             null
             seq))

(reverse-2 (list 1 2 3 4 5 6))