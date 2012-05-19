;; Example 1.22

(define runtime current-inexact-milliseconds)

;; prime finding functions

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

;; timed prime test functions

(define (report-prime elapsed)
  (display " *** ")
  (display elapsed))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(timed-prime-test 19)
(timed-prime-test 199)
(timed-prime-test 1999)

;; search for primes functions

;(define (search-for-primes start end)
;  (define (iter counter)
;    (cond ((= counter end) 0)
;          ((not (even? counter)) (timed-prime-test counter))
;          (else (iter (+ counter 1)))))
;  (iter start))

;(search-for-primes 0 100)