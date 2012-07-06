;; Example 3.1

(define (make-accumulator val)
  (λ (new-val)
    (set! val (+ val new-val))
    val))

(define A (make-accumulator 5))
(A 10)
(A 10)