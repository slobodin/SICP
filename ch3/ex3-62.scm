;; Example 3.62

#lang racket

(require racket/stream)

;; without testing

(define (div-series S1 S2)
  (let ((i2 (stream-first S2)))
    (if (= 0 i2)
        (error "Division by zero")
        (scale-stream (mul-series S1
                                  (invert-unit-series (scale-stream S2 (/ 1. i2))))
                      (/ 1. i2)))))

;; tg = sin/cos