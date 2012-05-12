;; Example 1.9

(define (inc a)
  (+ a 1))

(define (dec a)
  (- a 1))

;; linear recursive process
(define (plus-rec a b)
  (if (= a 0)
      b
      (inc (plus-rec (dec a) b))))

;; first we decrementing `a' a times (to zero)
;; then we incrementing `b' a times (when returning from all functions)
(plus-rec 4 5)

;; linear iterative process
(define (plus-iter a b)
  (if (= a 0)
      b
      (plus-iter (dec a) (inc b))))

;; dec and inc are "parallel", when entering new func
(plus-iter 5 5)
