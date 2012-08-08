;; Example 3.28

(define (logical-or s1 s2)
  (cond ((and (= s1 0) (= s2 0)) 0)
        (else 1)))

(define (or-gate o1 o2 output)
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal o1)
                                 (get-signal o2))))
      (after-delay or-gate-delay
                   (λ () (set-signal! output new-value)))))
  (add-action! o1 or-action-procedure)
  (add-action! o2 or-action-procedure)
  'ok)