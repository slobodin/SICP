;; Example 2.9

(define (make-interval a b) 
  (cons a b))
(define (lower-bound interval)
  (car interval))
(define (upper-bound interval)
  (cdr interval))
(define (width interval)
  (/ (- (upper-bound interval) (lower-bound interval)) 2.0))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y)))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define i1 (make-interval 5 10))
(define i2 (make-interval 6 8))

(width i1)
(width i2)
(width (add-interval i1 i2))
(width (mul-interval i1 i2))

(define i3 (make-interval 7 12))
(define i4 (make-interval 5 7))

(width i3)
(width i4)
(width (add-interval i3 i4))
(width (mul-interval i3 i4))