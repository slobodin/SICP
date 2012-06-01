(list 1 2 3 4)
(define one-through-four (list 1 2 3 4))
one-through-four

(car one-through-four)
(cdr one-through-four)
(car (cdr one-through-four))

(cons 10 one-through-four)
(cons 5 one-through-four)

(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

(define squares (list 1 4 9 16 25))
(list-ref squares 3)

(define (lenght items)
  (if (null? items)
      0
      (+ 1 (lenght (cdr items)))))

(lenght squares)

(define odds (list 1 3 5 7))
(lenght odds)

(define (lenght-iter items)
  (define (iter items counter)
    (if (null? items)
        counter
        (iter (cdr items) (+ counter 1))))
  (iter items 0))

(lenght-iter odds)
(lenght-iter squares)

(display "----- Append test -----\n")

(define (my-append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (my-append (cdr list1) list2))))

(my-append odds squares)
(my-append squares odds)