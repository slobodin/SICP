(require (lib "racket/draw"))
(require racket/class)

(define target (make-bitmap 100 100))
(define dc (new bitmap-dc% [bitmap target]))

;; Vectors

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

(define (scale-vect s a)
  (make-vect (* (xcor-vect a) s)
             (* (ycor-vect a) s)))

;; Frames

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

;; Coords mapping

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect 
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

;((frame-coord-map a-frame) (make-vect 0 0))

;; Segments

(define (make-segment v1 v2)
  (cons v1 v2))

(define (start-segment v1)
  (car v1))

(define (end-segment v2)
  (cdr v2))

;; Painters

(define (my-draw-line v1 v2)
  (send dc draw-line
        (xcor-vect v1) (ycor-vect v1)
        (xcor-vect v2) (ycor-vect v2)))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (my-draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

;; Transform

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
         (make-frame new-origin
                     (sub-vect (m corner1) new-origin)
                     (sub-vect (m corner2) new-origin)))))))

(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              split-point
                              (make-vect 0.0 1.0)))
          (paint-right
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.0)
                              (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-bottom
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              (make-vect 1.0 0.0)
                              split-point))
          (paint-top
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.5)
                              (make-vect 0.0 1.0))))
      (lambda (frame)
        (paint-bottom frame)
        (paint-top frame)))))

(define (split f s)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split f s) painter (- n 1))))
          (f painter (s smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below half (flip-vert half)))))

;; Painting

(define rhomb (segments->painter 
               (list (make-segment 
                      (make-vect 0 0.5) 
                      (make-vect 0.5 0))
                     (make-segment 
                      (make-vect 0.5 0) 
                      (make-vect 1 0.5))
                     (make-segment
                      (make-vect 1 0.5)
                      (make-vect 0.5 1))
                     (make-segment
                      (make-vect 0.5 1)
                      (make-vect 0 0.5)))))

;; Testing

(send dc clear)
(rhomb (make-frame (make-vect 0 0) (make-vect 0 100) (make-vect 100 0)))
(send target save-file "test-rhomb.png" 'png)

(send dc clear)
((corner-split rhomb 6) 
 (make-frame (make-vect 0 0) (make-vect 0 100) (make-vect 100 0)))
(send target save-file "test-rhomb-corner.png" 'png)

(send dc clear)
((square-limit rhomb 6) 
 (make-frame (make-vect 0 0) (make-vect 0 100) (make-vect 100 0)))
(send target save-file "test-rhomb-sq.png" 'png)

(send dc clear)
((right-split rhomb 6) 
 (make-frame (make-vect 0 0) (make-vect 100 0) (make-vect 0 100)))
(send target save-file "test-rhomb-right.png" 'png)

;; something wrong with basis....