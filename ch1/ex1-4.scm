;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ex1-4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;; Example 1.4.
;; Observe that our model of evaluation allows for 
;; combinations whose operators are compound expressions.
;; Use this observation to describe the behavior of the following procedure: 

(define (a-plus-abs-b a b)
  ((if (> b 0) 
       + 
       -) 
   a 
   b))

(a-plus-abs-b 5 -5)

;; ((if (> -5 0) + -) 5 -5))
;; ((- 5 -5))
;; 5 + 5 = 10