;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ex1-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;; Example 1.1

10

;; => 10

(+ 5 3 4)

;; => 12

(- 9 1)

;; => 8

(/ 6 2)

;; => 3

(+ (* 2 4) (- 4 6))

;; => 6

(define a 3)

;;

(define b (+ a 1))

;;

(+ a b (* a b))

;; => 19

(if (and (> b a) (< b (* a b)))
    b
    a)

;; => 4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

;; => 16

(+ 2 (if (> b a) b a))

;; => 6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))

;; => 16
