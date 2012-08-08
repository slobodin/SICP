;; Example 3.30

(define (riple-carry-adder a-num b-num s-num c)
  (define (clock A B S Carry)
    (if (null? A)
        'ok
        (let ((ai (car A))
              (bi (car B))
              (si (car S))
              (c-out (make-wire)))
          (full-adder ai bi Carry si c-out)
          (clock (cdr A) (cdr B) (cdr S) c-out))))
              
  (if (not (= (length a-num) (length b-num) (length s-num)))
      (error "Bad numbers passed in adder-proc")
      (clock a-num b-num s-num c)))

;; delay

;; half-adder-delay = max ( (or-delay + and-delay), (2 * and-delay + inv-delay) )
;; full-adder-delay = 2 * half-adder-delay + or-delay
;; delay = n * full-adder-delay