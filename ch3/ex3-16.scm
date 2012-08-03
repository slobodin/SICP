;; Example 3.16

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(def

(count-pairs (list 1 2 3))

(define x (list 1))
(count-pairs (list x x))