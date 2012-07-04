;; Example 2.70

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

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))


(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge ordered-leaves)
  (if (= 1 (length ordered-leaves))
      (car ordered-leaves)
      (let ((first (car ordered-leaves))
            (second (cadr ordered-leaves))
            (rest (cddr ordered-leaves)))
        (successive-merge (adjoin-set (make-code-tree first second)
                                      rest)))))

(define sample-list (list (list 'A 2) (list 'BOOM 1) (list 'GET 2) (list 'JOB 2)
                          (list 'NA 16) (list 'SHA 3) (list 'YIP 9) (list 'WAH 1)))

(define song-tree (generate-huffman-tree sample-list))

(encode '(GET A JOB) song-tree)
(encode '(SHA NA NA NA NA NA NA NA NA) song-tree)
(encode '(WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP) song-tree)
(encode '(SHA BOOM) song-tree)
(decode (encode '(SHA BOOM) song-tree) song-tree)