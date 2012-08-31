;; Example 4.21

;; First lambda applies to 10
;; Second lambda applies to ft, then ft(ft 10)
;; 

((lambda (n)
   ((lambda (fact)
      (fact fact n))
    (lambda (ft k)
      (if (= k 1)
          1
          (* k (ft ft (- k 1)))))))
 10)

((lambda (n)
   ((lambda (fib)
      (fib fib n))
    (lambda (f k)
      (cond ((= k 0) 0)
            ((= k 1) 1)
            (else (+ (f f (- k 1)) (f f (- k 2))))))))
 7)

(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) #t (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) #f (ev? ev? od? (- n 1))))))

(f 10)
(f 12)
(f 7)
(f 5)