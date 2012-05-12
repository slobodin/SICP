;; Example 1.2
;; Translate the following expression into prefix form

(define a (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))))
(define b (* 3 (- 6 2) (- 2 7)))

(/ a b)

;; check, a / b == -0.246