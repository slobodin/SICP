;; Example 2.46

(define (make-vect x y)
  (cons x y))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

(define (add-vect a b)
  (make-vect (+ (xcor-vect a) (xcor-vect b))
             (+ (ycor-vect a) (ycor-vect b))))

(define (sub-vect a b)
  (make-vect (- (xcor-vect a) (xcor-vect b))
             (- (ycor-vect a) (ycor-vect b))))

(define (scale-vect a s)
  (make-vect (* (xcor-vect a) s)
             (* (ycor-vect a) s)))

(define a (make-vect 1 2))
(define b (make-vect 4 5))

(add-vect a b)
(sub-vect a b)
(scale-vect a 2)