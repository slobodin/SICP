;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ex1-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;; Example 1.2
;; Translate the following expression into prefix form

(define a (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))))
(define b (* 3 (- 6 2) (- 2 7)))

(/ a b)

;; check, a / b == -0.246