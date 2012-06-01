;; Example 2.20

(define (same-parity checked . lst)
  (define (helper pred inp result)
    (cond ((null? inp) (reverse result))    ;; just crutch
          ((pred (car inp)) 
           (helper pred (cdr inp) (cons (car inp) result)))
          (else (helper pred (cdr inp) result))))

  (if (even? checked)
      (helper even? lst ())
      (helper odd? lst ())))

(same-parity 2 1 2 3 4 5 6)
(same-parity 3 1 2 3 4 5 6)