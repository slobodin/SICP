;; Example 2.12

(define (make-interval a b) 
  (cons a b))
(define (lower-bound interval)
  (car interval))
(define (upper-bound interval)
  (cdr interval))
(define (width interval)
  (/ (- (upper-bound interval) (lower-bound interval)) 2.0))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2.0))

(define (make-center-percent c per)
  (make-interval (- c (* c (/ per 100)))
                 (+ c (* c (/ per 100)))))
(define (percent i)
  (let ((center (center i))
        (lw (lower-bound i))
        (up (upper-bound i)))
    (* (/ (- up center) center) 100)))
    
(define i1 (make-center-percent 6.8 10))
i1
(percent i1)