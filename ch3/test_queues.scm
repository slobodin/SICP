(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue)
  (null? (front-ptr queue)))

;; Constructs an empty queue
(define (make-queue) (cons '() '()))

;; Object in the head of queue
(define (front-queue queue)
  (if (empty-queue? queue)
      (error "Front called with empty queue")
      (car (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-cdr! (rear-ptr queue) new-pair)
           (set-rear-ptr! queue new-pair)
           queue))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "Attempt to delete from empty queue"))
        (else
         (set-front-ptr! queue (cdr (front-ptr queue)))
         queue)))

(define q1 (make-queue))
q1

(insert-queue! q1 'a)
(insert-queue! q1 'b)
(insert-queue! q1 'c)
(delete-queue! q1)
(delete-queue! q1)