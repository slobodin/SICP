;; Fibonacci.

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

;;
(display "recursively\n")
(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 6)

(define (fib-iter n)
  (define (iter a b counter)
    (if (= counter n)
        b
        (iter b (+ a b) (+ counter 1))))
  
  (iter 0 1 1))

;;
(display "iterative\n")
(fib-iter 1)
(fib-iter 2)
(fib-iter 3)
(fib-iter 4)
(fib-iter 5)
(fib-iter 6)