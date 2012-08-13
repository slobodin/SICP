;; queues

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

;; primitives

(define (logical-not s)
  (cond ((= s 0) 1)
        ((= s 1) 0)
        (else (error "Bad signal" s))))

(define (logical-and s1 s2)
  (cond ((and (= s1 1) (= s2 1)) 1)
        (else 0)))    ;; without bad signal

(define (logical-or s1 s2)
  (cond ((and (= s1 0) (= s2 0)) 0)
        (else 1)))

(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

;; wire stuff

;; invokes every procedure from the given procedures list
(define (call-each procedures)
  (if (null? procedures)
      'done
      (begin
        ((car procedures))
        (call-each (cdr procedures)))))

;; wire ctor
(define (make-wire)
  (let ((signal-value 0)
        (action-procedures '()))
    
    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
          (begin (set! signal-value new-value)
                 (call-each action-procedures))
          'done))
    
    (define (accept-action-procedure! proc)
      (set! action-procedures (cons proc action-procedures))
      (proc))
    
    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal-value)
            ((eq? m 'set-signal!) set-my-signal!)
            ((eq? m 'add-action!) accept-action-procedure!)
            (else (error "Unknown operation -- WIRE" m))))
    
    dispatch))

(define (get-signal wire)
  (wire 'get-signal))

(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))

(define (add-action! wire action-procedure)
  ((wire 'add-action!) action-procedure))

;; agenda

(define (make-time-segment time queue)
  (cons time queue))
(define (segment-time s) (car s))
(define (segment-queue s) (cdr s))

(define (make-agenda) (list 0))
(define the-agenda (make-agenda))

(define (current-time agenda) (car agenda))
(define (set-current-time! agenda time)
  (set-car! agenda time))

(define (segments agenda) (cdr agenda))
(define (set-segments! agenda segments)
  (set-cdr! agenda segments))

(define (first-segment agenda) (car (segments agenda)))
(define (rest-segments agenda) (cdr (segments agenda)))

(define (empty-agenda? agenda)
  (null? (segments agenda)))

(define (add-to-agenda! time action agenda)
  (define (belongs-before? segments)
    (or (null? segments)
        (< time (segment-time (car segments)))))
  (define (make-new-time-segment time action)
    (let ((q (make-queue)))
      (insert-queue! q action)
      (make-time-segment time q)))
  (define (add-to-segments! segments)
    (if (= (segment-time (car segments)) time)
        (insert-queue! (segment-queue (car segments))
                       action)
        (let ((rest (cdr segments)))
          (if (belongs-before? rest)
              (set-cdr! segments (cons (make-new-time-segment time action)
                                       (cdr segments)))
              (add-to-segments! rest)))))
  (let ((segments (segments agenda)))
    (if (belongs-before? segments)
        (set-segments! agenda
                       (cons (make-new-time-segment time action)
                             segments))
        (add-to-segments! segments))))

(define (remove-first-agenda-item! agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (delete-queue! q)
    (if (empty-queue? q)
        (set-segments! agenda (rest-segments agenda)))))

(define (first-agenda-item agenda)
  (if (empty-agenda? agenda)
      (error "Agenda empty")
      (let ((first-seg (first-segment agenda)))
        (set-current-time! agenda (segment-time first-seg))
        (front-queue (segment-queue first-seg)))))

(define (after-delay del action)
  (add-to-agenda! (+ del (current-time the-agenda))
                  action
                  the-agenda))

(define (propagate)
  (if (empty-agenda? the-agenda)
      'done
      (let ((first-item (first-agenda-item the-agenda)))
        (first-item)
        (remove-first-agenda-item! the-agenda)
        (propagate))))

;; functional boxes

(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! input invert-input)  ;; add listener
  'ok)

(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value (logical-and (get-signal a1)
                                  (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)

(define (or-gate o1 o2 output)
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal o1)
                                 (get-signal o2))))
      (after-delay or-gate-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! o1 or-action-procedure)
  (add-action! o2 or-action-procedure)
  'ok)

;; half adder

(define (half-adder a b s c)
  (let ((d (make-wire))
        (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))

;; full adder

(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

;; riple adder

(define (riple-carry-adder a-num b-num s-num c)
  (if (not (= (length a-num) (length b-num) (length s-num)))
      (error "Bad numbers passed in adder-proc")
      (let ((c-in (make-wire)))
        (if (null? (cdr a-num))
            (set-signal! c-in 0)
            (riple-carry-adder (cdr a-num) (cdr b-num) (cdr s-num) c-in))
        (full-adder (car a-num) (car b-num) c-in (car s-num) c))))

(define (display-status wires)
  (for-each (lambda (arg) (display (get-signal arg))) wires)
  (newline))

(define a1 (make-wire))
(define a2 (make-wire))
(define a3 (make-wire))
(define a4 (make-wire))
(define b1 (make-wire))
(define b2 (make-wire))
(define b3 (make-wire))
(define b4 (make-wire))

;; 0101
;; 0011
;; ----
;; 1000

(set-signal! a2 1)
(set-signal! a4 1)
(set-signal! b3 1)
(set-signal! b4 1)

(define a (list a1 a2 a3 a4))
(define b (list b1 b2 b3 b4))
(define sum (list (make-wire) (make-wire) (make-wire) (make-wire)))

(riple-carry-adder a b sum (make-wire))

(display-status a)
(display-status b)

(propagate)

(display-status sum)