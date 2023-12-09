(define (set-union A B)
  (cond
    ((null? A) B)
    ((member (car A) B) (set-union (cdr A) B))
    (else (cons (car A) (set-union (cdr A) B)))))

(define (set-intersection A B)
  (cond
    ((null? A) ())
    ((member (car A) B) (cons (car A) (set-intersection (cdr A) B)))
    (else (set-intersection (cdr A) B))))

(define (set-diff A B)
    (cond
      ((null? A) ())
      ((member (car A) B) (set-diff (cdr A) B))
      (else (cons (car A) (set-diff (cdr A) B)))))

(define A '(1 2 3 4 5))
(define B '(2 4 6 8 10))

(newline)
(write 'A)   (write '=>)   (write A) (newline)
(write 'B)   (write '=>)   (write B) (newline)
(write 'AUB)   (write '=>)   (write (set-union A B)) (newline)
(write 'A^B)   (write '=>)   (write (set-intersection A B)) (newline)
(write 'A-B)   (write '=>)   (write (set-diff A B)) (newline)
(write 'B-A)   (write '=>)   (write (set-diff B A)) (newline)
(write '((A-B)U(B-A))) (write '=>)(write (set-union (set-diff A B)(set-diff B A))) (newline)
(write '((AUB)-(A^B))) (write '=>)(write (set-diff (set-union A B) (set-intersection A B))) (newline)
