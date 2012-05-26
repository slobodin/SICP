;; Example 1.33

(define (filter-accumulate combiner null-value func a next b pred?)
  (define (iter curr-a result)
    (cond ((> curr-a b) result)
          ((pred? curr-a) (iter (next curr-a)
                                (combiner result (func curr-a))))
          (else (iter (next curr-a) result))))
  
  (iter a null-value))

;; Part a. Sum of squared primes in [a, b]

(define (smallest-divisor n)
  (find-divisor n 2))

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (identity x) x)
(define (inc n) (+ n 1))

(define (sum-prime-squares a b)
  (filter-accumulate + 0 square a inc b prime?)) 

(sum-prime-squares 1 10) ;; yes, it equals to 88, I checked. (it includes '1' too, as prime)
(sum-prime-squares 1 100)

;; Part b. GCD

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (product-primes-to-n n)
  (define (pred a)
    (= (gcd a n) 1))
  (filter-accumulate * 1 identity 1 inc n pred))

(product-primes-to-n 10)