;; Example 4.20

;; ((letrec? exp) (meval (letrec->let (cdr exp)) env))

(define (make-begin seq) (cons 'begin seq))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      #f))

;; a

(define (letrec? exp) (tagged-list? exp 'letrec))
(define (letrec-vars-and-exps exp) (car exp))
(define (letrec-body exp) (cdr exp))
(define (letrec->let exp)
  (list 'let 
        (map (lambda (var-exp) (list (car var-exp) ''*unassigned)) (letrec-vars-and-exps exp))
        (make-begin (append (map (lambda (var-exp) (list 'set! (car var-exp) (cadr var-exp))) (letrec-vars-and-exps exp))
                            (letrec-body exp)))))

(define t '(letrec ((y 2)
                    (x 42))
             (+ x y)
             (* x y)))

(letrec->let (cdr t))

;; b