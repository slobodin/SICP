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
  (display elapsed)
  #t)

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))
      #f))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

;(timed-prime-test 19)
;(timed-prime-test 199)
;(timed-prime-test 1999)

;; search for primes functions

(define (next n)
  (if (even? n) (+ n 1)
      (+ n 2)))

(define (search-for-primes start end)
  (define (iter odd-num)
    (timed-prime-test odd-num)
    (if (>= odd-num (- end 1)) (void)
        (iter (next odd-num))))
  (iter (next (- start 1))))

(define (first-three-after start)
  (define (iter i number)
    (cond ((= i 3) (void))
          ((timed-prime-test number) (iter (+ i 1) (next number)))
          (else (iter i (next number)))))
  (iter 0 start))

(first-three-after 100)
(first-three-after 10000)
(first-three-after 100000)
(first-three-after 1000000)

;; Can't explain in English.