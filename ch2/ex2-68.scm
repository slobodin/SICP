;; Example 2.68

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? leaf)
  (eq? 'leaf (car leaf)))

(define (symbol-leaf leaf) (cadr leaf))
(define (weight-leaf leaf) (caddr leaf))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree)) ;; leaf symbol
      (caddr tree)))            ;; symbols of the tree node (not leaf)

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))    ;; found symbol. Starting from the root again
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= 0 bit) (left-branch branch))
        ((= 1 bit) (right-branch branch))
        (else (error "Bad bit while choosing branch"))))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(define decoded-msg (decode sample-message sample-tree))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (if (leaf? tree)
      '()
      (let ((lb (left-branch tree))
            (rb (right-branch tree)))
        (cond ((find-symbol symbol lb) (cons '0 (encode-symbol symbol lb)))
              ((find-symbol symbol rb) (cons '1 (encode-symbol symbol rb)))
              (else (error "No such symbol in the Huffman tree"))))))

(define (find-symbol symbol branch)
  (define (helper symbol syms)
    (if (null? syms)
        #f
        (if (eq? symbol (car syms))
            #t
            (helper symbol (cdr syms)))))
  (helper symbol (symbols branch)))

;; Start test

sample-message
(encode decoded-msg sample-tree)