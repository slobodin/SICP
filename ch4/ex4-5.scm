#lang racket

;; Example 4.5

;; Need testing.

(define (cond=>clause? exp)
  (eq? (cadr exp) '=>))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (cond ((cond=>clause? first)
               (make-if (car first)       ;; (if (test?) (list recipient test) ..)
                        (list (caddr first) (car first)) 
                        (expand-clauses rest)))
              ((cond-else-clause? first)
               (if (null? rest)
                   (sequence->exp (cond-actions first))
                   (error "Clause else not the last" clauses)))
              (else (make-if (cond-predicate first)
                             (sequence->exp (cond-actions first))
                             (expand-clauses rest)))))))