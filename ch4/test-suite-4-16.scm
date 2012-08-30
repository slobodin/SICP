(define (test)
  (define u (+ 2 2))
  (define v (+ 3 3))
  (define (square x)
    (* x x))

  (+ u u)
  (+ v (square u) u))
(test)