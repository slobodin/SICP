;; Example 1.5
;; Ben Bitdiddle blablabla

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))

;; Normal order - full substitude, without evaluating the arguments.
;; After subst. - full evaluate.
;; test 0 p
;; if (= 0 0) 0 p
;; 0

;; Applicative order - evaluates arguments, then substitute it in function
;; test 0 (p)    ;; sic ()
;; test 0 (p)
;; etc
;; forever loop