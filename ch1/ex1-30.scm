;; Example 1.30

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  
  (iter a 0))

(define (cube x)
  (* x x x))

(define (inc n)
  (+ n 1))

(define (sum-cubes a b)
  (sum cube a inc b))

(sum-cubes 5 7)