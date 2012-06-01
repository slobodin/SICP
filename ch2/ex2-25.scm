;; Example 2.25

;; case 1
(display "x1: ")
(define x1 (list 1 3 (list 5 7) 9))
x1
(display "x1: ")
(car (cdr (car (cdr (cdr x1)))))

;; case 2
(display "x2: ")
(define x2 (list (list 7)))
x2
(display "x2: ")
(car (car x2))

;; case 3
(display "x3: ")
(define x3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
x3
(display "x3: ")
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr x3))))))))))))