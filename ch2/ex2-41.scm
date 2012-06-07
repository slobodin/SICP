;; Examle 2.41

;; Helpers

(define (fold-right op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (fold-right op initial (cdr seq)))))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low
            (enumerate-interval (+ low 1) high))))

(define (filter predicate seq)
  (cond ((null? seq) null)
        ((predicate (car seq))
         (cons (car seq) (filter predicate (cdr seq))))
        (else (filter predicate (cdr seq)))))

(define (flatmap proc seq)
  (fold-right append null (map proc seq)))

(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

(define (unique-triplets n)
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k) (list i j k))
                             (enumerate-interval 1 (- j 1))))
                      (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

(unique-triplets 6)

(display "--- result --- \n")

(define (triplets-equals-to s n)
  (filter (lambda (triplet) (= (fold-right + 0 triplet) s))
          (unique-triplets n)))

(triplets-equals-to 10 6)