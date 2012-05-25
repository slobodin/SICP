;; Part 1.3.1

(define (cube x)
  (* x x x))

(define (sum-integers a b)
  (if (> a b) 0
      (+ a (sum-integers (+ a 1) b))))

(sum-integers 5 7)

(define (sum-cubes a b)
  (if (> a b) 0
      (+ (cube a) (sum-cubes (+ a 1) b))))

(sum-cubes 5 7)

(define (pi-sum a b)
  (if (> a b) 0
      (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))

(pi-sum 1 10000)
(* (pi-sum 1 10000) 8)