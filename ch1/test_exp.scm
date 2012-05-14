;; test exp

(define (square x)
  (* x x))

;; recursive
;; O(n) steps, O(n) memory
(define (exp-rec b n)
  (if (= n 0) 1
      (* b  (exp-rec b (- n 1)))))

;; test
(exp-rec 1 2)
(exp-rec 2 8)
(exp-rec 3 3)
(exp-rec 4 4)
(exp-rec 5 5)
(exp-rec 70 2)

;; iterate
;; O(n) steps, O(1) memory
(define (exp-iter b n)
  (define (iter product counter)
    (if (= counter 0)
        product
        (iter (* product b) (- counter 1))))
  
  (iter 1 n))

;; test
(exp-iter 1 2)
(exp-iter 2 8)
(exp-iter 3 3)
(exp-iter 4 4)
(exp-iter 5 5)
(exp-iter 70 2)

;(exp-iter 2 1000)

;; optimized exp
(define (fast-exp b n)
  (cond ((= n 0) 1)
        ((even? n) (fast-exp (* b b) (/ n 2)))
        (else (* b (fast-exp b (- n 1))))))

;; test
(fast-exp 1 2)
(fast-exp 2 8)
(fast-exp 3 3)
(fast-exp 4 4)
(fast-exp 5 5)
(fast-exp 70 2)

;(fast-exp 2 1000)