;; Example 2.2

;; Point
(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

;; Segment
(define (make-segment p1 p2)
  (cons p1 p2))
(define (start-segment p)
  (car p))
(define (end-segment p)
  (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))

(define (midpoint-segment segment)
  (let ((x1 (x-point (start-segment segment)))
        (x2 (x-point (end-segment segment)))
        (y1 (y-point (start-segment segment)))
        (y2 (y-point (end-segment segment))))
    (make-point (/ (+ x1 x2) 2.0)
                (/ (+ y1 y2) 2.0))))

;; test
(define p1 (make-point 1 1))
(define p2 (make-point 4 3))
(define seg (make-segment p1 p2))

(print-point (midpoint-segment seg))

