;; Example 2.29

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;; part a.
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define mobile (make-mobile (make-branch 5
                                         (make-mobile (make-branch 17 6)
                                                      (make-branch 26 22)))
                            (make-branch 20 20)))

(define (mobile? items)
  (pair? items))

(define (total-weight mobile)
  (if (not (mobile? mobile))
      mobile
      (+ (total-weight (left-branch mobile))
         (total-weight (right-branch mobile)))))

(total-weight mobile)

(define (balanced? mobile)
  0)