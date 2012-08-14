;; In order to use `parallel-execute' you need this:
;; http://planet.racket-lang.org/display.ss?package=sicp-concurrency.plt&owner=dyoo
;; install package, reboot drracket, change language to "SICP Concurrency language"

(define x 10)

(parallel-execute (lambda () (set! x (* x x)))
                  (lambda () (set! x (+ x 1))))

x