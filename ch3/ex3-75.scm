;; Example 3.75

#lang racket

(require racket/stream)

(define (make-zero-crossings input-stream last-value last-avpt)
  (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
    (stream-cons (sign-change-detectpr avpt last-avpt)
                 (make-zero-crossings (stream-rest input-stream)
                                      (stream-first input-stream)
                                      avpt))))