;; Example 3.8

(define f
  (let ((flag #f))
    (λ (x)
      (if flag
          x
          (begin (set! flag #t)
                 (- x 1))))))

(+ (f 0) (f 1))