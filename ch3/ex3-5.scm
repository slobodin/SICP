;; Example 3.5

(define (square x)
  (* x x))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (monte-carlo trials experiment)
  (define (iter trial-remaining trial-passed)
    (cond ((= 0 trial-remaining)
           (/ trial-passed trials))
          ((experiment)
           (iter (- trial-remaining 1) (+ trial-passed 1)))
          (else
           (iter (- trial-remaining 1) trial-passed))))
  (iter trials 0))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (* (monte-carlo trials P) (* (abs (- x2 x1))
                               (abs (- y2 y1))) 1.0))

(define (compute-integral x1 x2 y1 y2 trials)
  (estimate-integral (lambda ()
                       (let ((x (random-in-range x1 x2))
                             (y (random-in-range y1 y2))
                             (r (/ (abs (- x2 x1)) 2))
                             (x0 (+ x1 (/ (abs (- x2 x1)) 2)))
                             (y0 (+ y1 (/ (abs (- x2 x1)) 2))))
                         (<= (+ (square (- x x0)) (square (- y y0)))
                             (square r))))
                     x1 x2 y1 y2 trials))

(compute-integral 0 2 0 2
                  500000)
                         