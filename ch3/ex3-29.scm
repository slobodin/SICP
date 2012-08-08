;; Example 3.29

;; -- O1 ----|---|
;;         | | & |-0-----|
;;         |_|   |       |
;;           |___|       |___|---|
;;                           | & |-0---
;; -- O2 ----|---|       |---|___|
;;         | | & |-0-----|
;;         |_|   |
;;           |___|

(define (or-gate o1 o2 output)
  (let ((o1-and (make-wire))
        (o2-and (make-wire))
        (not-o1-and (make-wire))
        (not-o2-and (make-wire))
        (res (make-wire)))
    (and-gate o1 o1 o1-and)
    (and-gate o2 o2 o2-and)
    (inverter o1-and not-o1-and)
    (inverter o2-and not-o2-and)
    (and-gate not-o1-and not-o2-and res)
    (inverter res output)
    'ok))

;; delay = 2 * and-delay + 2 * inverter-delay