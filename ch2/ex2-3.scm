;; Example 2.3

;; Point
(define (make-point x y)
  (cons x y))
(define (x-point p)
  (car p))
(define (y-point p)
  (cdr p))

;; Rectangle
;; 1 ver
(define (make-rectangle left-top right-bottom)
  (cons left-top right-bottom))
(define (rect-left-top rect)
  (car rect))
(define (rect-right-bottom rect)
  (cdr rect))

;; 2 ver - for example, use segment (left-top, right-bottom) 
;; to describe the rectangle.
;; I just too lazy to implement this version.

(define (rect-square rect)
  (let ((p1 (rect-left-top rect))
        (p2 (rect-right-bottom rect)))
    (* (abs (- (x-point p2) (x-point p1)))
       (abs (- (y-point p2) (y-point p1))))))

(define (rect-perim rect)
  (let ((p1 (rect-left-top rect))
        (p2 (rect-right-bottom rect)))
    (* (+ (abs (- (x-point p2) (x-point p1)))
          (abs (- (y-point p2) (y-point p1))))
       2)))

(define rect-1 (make-rectangle (make-point 1 1)
                             (make-point 4 -5)))

(rect-square rect-1)
(rect-perim rect-1)

(define rect-2 (make-rectangle (make-point 2 2)
                               (make-point 3 3)))
(rect-square rect-2)
(rect-perim rect-2)