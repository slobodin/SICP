(define (square a)
  (* a a))

(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
        ((not (pair? tree))
         (if (odd? tree) (square tree) 0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))

(define tree (list (list 1 2) (list 2 (list 3 5))))
tree

(sum-odd-squares tree)

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (even-fibs n)
  (define (next k)
    (if (> k n)
        null
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))

(even-fibs 10)

(define (fibs n)
  (define (next k)
    (if (> k n)
        null
        (cons (fib k) (next (+ k 1)))))
  (next 0))

(fibs 10)

(define (filter predicate seq)
  (cond ((null? seq) null)
        ((predicate (car seq))
         (cons (car seq) (filter predicate (cdr seq))))
        (else (filter predicate (cdr seq)))))

(filter odd? (list 1 2 3 4 5))

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

(accumulate + 0 (list 1 2 3 4 5))
(accumulate * 1 (list 1 2 3 4 5))
(accumulate cons null (list 1 2 3 4 5))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low
            (enumerate-interval (+ low 1) high))))

(enumerate-interval 2 7)

(define (enumerate-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define test-tree (list 1 (list 2 (list 3 4) 5)))
test-tree
(enumerate-tree test-tree)

;; NEW FUNC
(define (sum-odd-squares-new tree)
  (accumulate +
              0
              (map square (filter odd? (enumerate-tree tree)))))

(sum-odd-squares-new tree)

(define (even-fibs-new n)
  (accumulate cons
              null
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))

(even-fibs-new 10)

(define (list-fib-squares n)
  (accumulate cons
              null
              (map square (map fib
                               (enumerate-interval 0 n)))))

(list-fib-squares 10)

(define (product-of-squares-of-odd-elements seq)
  (accumulate *
              1
              (map square (filter odd? seq))))

(product-of-squares-of-odd-elements (list 1 2 3 4 5))