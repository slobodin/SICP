;; Example 3.23

;; node in deq is pair of pointer to data and pointer to another pair
;; which consists of two pointers - to the next node and to the previous

;; not resolved

;; helpers

(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))
(define (set-front-ptr! deque item) (set-car! deque item))
(define (set-rear-ptr! deque item) (set-cdr! deque item))

(define (set-prev-ptr! node item)
  (set-car! (cdr node) item))

(define (set-next-ptr! node item)
  (set-cdr! (cdr node) item))

;; new deque
(define (make-deque) (cons '() '()))

;; is deque empty?
(define (empty-deque? deque)
  (null? (front-ptr deque)))

;; front data selector
(define (front-deque deque)
  (cond ((empty-deque? deque)
         (error "Empty deque! -- FRONT-DEQUE"))
        (else
         (car (front-ptr deque)))))

;; rear data selector
(define (rear-deque deque)
  (cond ((empty-deque? deque)
         (error "Empty deque! -- REAR-DEQUE"))
        (else
         (car (rear-ptr deque)))))

;; push front
;(define (front-insert-deque! deque item)
;  (let ((new-pair (cons item (cons '() '()))))
;    (cond ((empty-deque? deque)
;           (set-front-ptr! deque new-pair)
;           (set-rear-ptr! deque new-pair)
;           deque)
;          (else
;           (set-cdr! new-pair (front-ptr deque))
;           (set-front-ptr! deque new-pair)
;           deque))))

;; push back
(define (rear-insert-deque! deque item)
  (let ((new-pair (cons item (cons '() '()))))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque new-pair)
           (set-next-ptr! new-pair new-pair)
           deque)
          (else
           (set-cdr! (rear-ptr deque) new-pair)
           (set-rear-ptr! deque new-pair)
           (set-next-ptr! new-pair rear-ptr
           deque))))

;; pop front
;(define (front-delete-deque! deque)
;  (cond ((empty-deque? deque)
;         (error "Attempt to delete from an empty deque"))
;        (else
;         (set-front-ptr! deque (cdr (front-ptr deque)))
;         deque)))

;; pop back
;(define (rear-delete-deque! deque)
;  (cond ((empty-deque? deque)
;         (error "Attempt to delete from an empty deque"))
;        (else
;         (
;          ;; need back pointer!
;          ))))

(define (print-deque deque)
  (front-ptr deque))

(define deq (make-deque))

(print-deque (rear-insert-deque! deq 'x))
(print-deque (rear-insert-deque! deq 'y))
(print-deque (rear-insert-deque! deq 'z))
(print-deque (rear-insert-deque! deq 'w))

;(print-deque (front-insert-deque! deq 'a))
;(print-deque (rear-insert-deque! deq 'a))
;(print-deque (front-insert-deque! deq 'b))

;(print-deque (front-delete-deque! deq))
;(print-deque (front-delete-deque! deq))
;(print-deque (front-delete-deque! deq))

(front-deque deq)
(rear-deque deq)