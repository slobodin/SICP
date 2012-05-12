;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ex1-5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
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