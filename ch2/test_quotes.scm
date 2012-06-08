(define a 1)
(define b 1)

(list a b)
(list 'a 'b)
(list 'a b)

(car '(a b c))

(cdr '(a b c))

(memq 'a '(b a c d))

(define (my-memq item x)
  (cond ((null? x) #f)
        ((eq? item (car x)) x)
        (else (my-memq item (cdr x)))))

(my-memq 'a '(b a c d))

(memq 'apple '(pear banana prune))

'(x (apple sauce) y apple pear)

(memq 'apple '(x (apple sauce) y apple pear))