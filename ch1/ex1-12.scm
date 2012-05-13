;; Example 1.12

;; Pascal's triangle.

(define (get-element x y)
  (cond ((or (= x 1) (= x y) (= y 1)) 1)
        (else (+ (get-element (- x 1) (- y 1))
                 (get-element x (- y 1))))))

;; test
(get-element 1 1)
(get-element 2 2)
(get-element 1 2)
(get-element 3 2)
(get-element 1 4)
(get-element 2 4)
(get-element 3 4)
(get-element 4 4)
(get-element 1 5)
(get-element 2 5)
(get-element 3 5)
(get-element 4 5)
(get-element 5 5)