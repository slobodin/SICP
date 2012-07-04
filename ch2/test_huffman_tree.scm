;; Huffman tree

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? leaf)
  (eq? 'leaf (car leaf)))

(define (symbol-leaf leaf) (cadr leaf))
(define (weight-leaf leaf) (caddr leaf))

(define my-leaf (make-leaf 'Afs 5))
my-leaf
(leaf? my-leaf)
(symbol-leaf my-leaf)
(weight-leaf my-leaf)