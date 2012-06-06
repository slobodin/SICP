;; Example 2.38

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

(accumulate + 0 (list 1 2 3 4 5))

(define (fold-left op initial seq)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial seq))

(accumulate / 1 (list 1 2 3))
;; 3/2

;; 1/6
(fold-left / 1 (list 1 2 3))

;; (1 (2 (3 ())))
(accumulate list null (list 1 2 3))

;; (()(((1) 2) 3))
(fold-left list null (list 1 2 3))

(accumulate + 0 (list 1 2 3 4 5))
(fold-left + 0 (list 1 2 3 4 5))