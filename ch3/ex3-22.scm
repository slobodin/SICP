;; Example 3.22

(define (make-queue)  
  (let ((front-ptr '())
        (rear-ptr '()))

    (define (empty-queue?)
      (null? front-ptr))
    
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond ((empty-queue?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair)
               front-ptr)
              (else
               (set-cdr! rear-ptr new-pair)
               (set! rear-ptr new-pair)
               front-ptr))))
    
    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "Attempt to delete from an empty queue"))
            (else
             (set! front-ptr (cdr front-ptr))
             front-ptr)))
    
    (define (dispatch m)
      (cond ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) delete-queue!)
            (else (error "Unknown queue operation" m))))
    dispatch))

(define (insert-queue! queue item) ((queue 'insert-queue!) item))
(define (delete-queue! queue) ((queue 'delete-queue!)))

(define q1 (make-queue))

(insert-queue! q1 'a)
(insert-queue! q1 'b)
(insert-queue! q1 'c)
(delete-queue! q1)
(delete-queue! q1)
(delete-queue! q1)
