;; Example 1.24

(define runtime current-inexact-milliseconds)

(define (square x)
  (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) 
         (remainder (square (expmod base (/ exp 2) m)) 
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

;; timed prime test functions

(define (prime? n)
  (fast-prime? n 5))

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

(timed-prime-test 19)
(timed-prime-test 199)
(timed-prime-test 1999)
(timed-prime-test 199999)
(timed-prime-test 10000079)
(timed-prime-test 199999991)

;; Results using 1.22 function

; sqrt(n)
;19 *** 0.134033203125#t
;199 *** 0.009033203125#t
;1999 *** 0.01513671875#t
;199999 *** 0.134033203125#t
;10000079 *** 0.930908203125#t
;19999999199 *** 91.281982421875#t

;; Results using 1.23 function
; sqrt(n) / 2
;19 *** 0.092041015625#t
;199 *** 0.005859375#t
;1999 *** 0.010986328125#t
;199999 *** 0.0830078125#t
;10000079 *** 0.56298828125#t
;19999999199 *** 49.744140625#t

;; Results using this function
; log(n)
;19 *** 0.195068359375#t
;199 *** 0.0361328125#t
;1999 *** 0.048095703125#t
;199999 *** 0.118896484375#t
;10000079 *** 0.150146484375#t
;199999991 *** 0.18896484375#t