;; Example 2.20

(define (square x)
  (* x x))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items null))

(square-list (list 2 3 4 5))

(define (square-list-2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items null))

(square-list-2 (list 2 3 4 5))

;; It's like in my implementation of exercise 2.20
;; Dude trying to construct list and number, 
;; then construct resulting list with number again
;; and again and again
;; It's like a
;; (((((5).4).3).2).1)
;; Imagine two C++ std::lists
;; iterate the first and pop_front value from current iterate position of first list
;; to the second