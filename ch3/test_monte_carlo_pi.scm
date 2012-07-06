;; Monte-carlo pi

(define (rand)
  (random 4294967080))

(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))

(define (monte-carlo trials experiment)
  (define (iter trial-remaining trial-passed)
    (cond ((= 0 trial-remaining)
           (/ trial-passed trials))
          ((experiment)
           (iter (- trial-remaining 1) (+ trial-passed 1)))
          (else
           (iter (- trial-remaining 1) trial-passed))))
  (iter trials 0))

(estimate-pi 1)
(estimate-pi 10)
(estimate-pi 100)
(estimate-pi 1000)