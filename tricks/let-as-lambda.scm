(define (test)
  (let ((x 1)
        (y 2))
    (display x)
    (newline)
    (display y)))

(test)

(newline)

(define (test-lambda-let)
  ((lambda (x y)
    (display x)
    (newline)
    (display y))
   5 6))

(test-lambda-let)