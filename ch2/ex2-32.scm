;; Example 2.32

(define (subsets s)
  (if (null? s)
      (list)
      (let ((rest (subsets (cdr s))))
        (append rest (map () rest)))))

(subsets (list 1 2 3))