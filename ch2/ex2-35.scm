;; Example 2.35

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

(define (count-leaves tree)
  (accumulate +
              0
              (map (lambda (x)
                     (if (pair? x)
                         (count-leaves x)
                         1))
                   tree)))

(define x (list (list 1 2) (list 3 4)))
x

(count-leaves x)
(count-leaves (list x x))