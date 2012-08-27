#lang racket

;; Example 4.1

;; very not sure

(define (list-of-values-l exps env)
  (if (no-operands? exps)
      '()
      (let* ((first (eval (first-operand exps) env))
             (rest (list-of-values-l (rest-operands exps) env)))
        (cons first rest))))

(define (list-of-values-r exps env)
  (if (no-operands? exps)
      '()
      (let* ((rest (list-of-values-r (rest-operands exps) env))
             (first (eval (first-operand exps) env)))
        (cons rest first))))