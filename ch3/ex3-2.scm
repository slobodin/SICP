;; Example 3.2

(define (make-monitored f)
  (let ((count 0))
    (lambda (arg)
      (cond ((eq? arg 'how-many-calls?) count)
            ((eq? arg 'reset-count) (set! count 0))
            (else (begin (set! count (+ count 1))
                         (f arg)))))))

(define s (make-monitored sqrt))

(s 100)
(s 100)
(s 100)
(s 'how-many-calls?)
(s 'reset-count)
(s 'how-many-calls?)