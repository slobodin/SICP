;; Example 2.45

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

(define (split f s)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split f s) painter (- n 1))))
          (f painter (s smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))
