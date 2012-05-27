;; Example 1.34

(define (square x)
  (* x x))

(define (f g)
  (g 2))

(f square)

(f (lambda (z) (* z (+ z 1))))

;(f f)

;; Trying to apply '2' as function
