;; Example 2.53

;; => (a b c)
(list 'a 'b 'c)
;; pass

;; => ((george))
(list (list 'george))
;; pass

;; => (y1 y2)
(cdr '((x1 x2) (y1 y2)))
;; fail. Should be ((y1 y2))

;; => (y1 y2)
(cadr '((x1 x2) (y1 y2))) 
;; pass

;; => #f
(pair? (car '(a short list)))
;; pass

;; => #f
(memq 'red '((red shoes) (blue socks)))
;; pass

;; => (red shoes blue socks)
(memq 'red '(red shoes blue socks))
;; pass