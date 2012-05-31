;; Example 2.5

(define (my-cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (factors a n)
  (define (iter counter result)
    (if (= (remainder counter a) 0)
        (iter (/ counter a) (+ result 1))
        result))
  (iter n 0))

(define (my-car z)
  (factors 2 z))

(define (my-cdr z)
  (factors 3 z))

(my-car (my-cons 4 5))
(my-cdr (my-cons 4 5))
  