;Define a set difference function set-diff, such that: (set-diff '(1 2 3 4) '(4 3 1 5)) ==> (2 5) (hint: use member function)

(define (diff set1 set2)
  (cond ((null? set1) '())
        ((member (car set1) set2)
         (diff (cdr set1) set2))
        (else (cons (car set1)
                    (diff (cdr set1) set2)))))
(define (set-diff set1 set2)
  (append (diff set1 set2) (diff set2 set1)))

;(display (set-diff '(1 2 3 4) '(4 3 1 5)))

; (append (set-diff '(1 2 3 4) '(4 3 1 5)) (set-diff '(4 3 1 5) '(1 2 3 4) ))

;List all solutions of 8-queen by running the depth-first-search program.
;深さ優先探索プログラムを使って8-queenのすべての解を列挙せよ。

;Depth-first search program
;; depth first search for N-Queen
;;
(define (depth-first-search n)
  (letrec ((lst (node-expand n '()))
    (solution '())
    (x '())
    (sum 0)
    (pop (lambda () (let ((y (car lst)))
      (set! lst (cdr lst)) y)))
    (push (lambda (y) (set! lst (append y lst))))
    (search (lambda ()
      (if (null? lst)                          
      (begin
                          ;  (display "Final cnt value: ")
                          ;  (display cnt)
                           (display "Final sum value: ")
                           (display sum)
                           (newline)
                           solution)
        (begin (set! x (pop))
          (display "lst= ")(display lst)
          (display " x= ") (display x)
          (newline)
          ; (set! cnt (+ cnt 1))
          (set! sum (+ sum (length lst)))
          (if (safe? x)
            (if (goal? x n)
              (set! solution (cons x
                solution))
              (push (node-expand n x))))
        (search))))))
    (search)))

(define (node-expand n lst)
  (if (zero? n) '()
    (cons (cons n lst) (node-expand (- n 1)
lst))))
;;
(define (safe? lst)
  (let ((new (car lst))
    (hlst (cdr lst)))
  (if (null? hlst) #t
    (safe-aux? new (+ new 1) (- new 1) hlst))))
;;
(define (safe-aux? new up down hlst)
  (if (null? hlst) #t
    (let ((pos (car hlst)))
      (and (not (= pos new))
        (not (= pos up))
        (not (= pos down))
        (safe-aux? new (+ up 1) (- down 1)
          (cdr hlst))))))
;;
(define (goal? x n) (= (length x) n))

;((4 2 7 3 6 8 5 1) (5 2 4 7 3 8 6 1) (3 5 2 8 6 4 7 1) (3 6 4 2 8 5 7 1) (5 7 1 3 8 6 4 2) (4 6 8 3 1 7 5 2) (3 6 8 1 4 7 5 2) (5 3 8 4 7 1 6 2) (5 7 4 1 3 8 6 2) (4 1 5 8 6 3 7 2) (3 6 4 1 8 5 7 2) (4 7 5 3 1 6 8 2) (6 4 2 8 5 7 1 3) (6 4 7 1 8 2 5 3) (1 7 4 6 8 2 5 3) (6 8 2 4 1 7 5 3) (6 2 7 1 4 8 5 3) (4 7 1 8 5 2 6 3) (5 8 4 1 7 2 6 3) (4 8 1 5 7 2 6 3) (2 7 5 8 1 4 6 3) (1 7 5 8 2 4 6 3) (2 5 7 4 1 8 6 3) (4 2 7 5 1 8 6 3) (5 7 1 4 2 8 6 3) (6 4 1 5 8 2 7 3) (5 1 4 6 8 2 7 3) (5 2 6 1 7 4 8 3) (6 3 7 2 8 5 1 4) (2 7 3 6 8 5 1 4) (7 3 1 6 8 5 2 4) (5 1 8 6 3 7 2 4) (1 5 8 6 3 7 2 4) (3 6 8 1 5 7 2 4) (6 3 1 7 5 8 2 4) (7 5 3 1 6 8 2 4) (7 3 8 2 5 1 6 4) (5 3 1 7 2 8 6 4) (2 5 7 1 3 8 6 4) (3 6 2 5 8 1 7 4) (6 1 5 2 8 3 7 4) (8 3 1 6 2 5 7 4) (2 8 6 1 3 5 7 4) (5 7 2 6 3 1 8 4) (3 6 2 7 5 1 8 4) (6 2 7 1 3 5 8 4) (3 7 2 8 6 4 1 5) (6 3 7 2 4 8 1 5) (4 2 7 3 6 8 1 5) (7 1 3 8 6 4 2 5) (1 6 8 3 7 4 2 5) (3 8 4 7 1 6 2 5) (6 3 7 4 1 8 2 5) (7 4 2 8 6 1 3 5) (4 6 8 2 7 1 3 5) (2 6 1 7 4 8 3 5) (2 4 6 8 3 1 7 5) (3 6 8 2 4 1 7 5) (6 3 1 8 4 2 7 5) (8 4 1 3 6 2 7 5) (4 8 1 3 6 2 7 5) (2 6 8 3 1 4 7 5) (7 2 6 3 1 4 8 5) (3 6 2 7 1 4 8 5) (4 7 3 8 2 5 1 6) (4 8 5 3 1 7 2 6) (3 5 8 4 1 7 2 6) (4 2 8 5 7 1 3 6) (5 7 2 4 8 1 3 6) (7 4 2 5 8 1 3 6) (8 2 4 1 7 5 3 6) (7 2 4 1 8 5 3 6) (5 1 8 4 2 7 3 6) (4 1 5 8 2 7 3 6) (5 2 8 1 4 7 3 6) (3 7 2 8 5 1 4 6) (3 1 7 5 8 2 4 6) (8 2 5 3 1 7 4 6) (3 5 2 8 1 7 4 6) (3 5 7 1 4 2 8 6) (5 2 4 6 8 3 1 7) (6 3 5 8 1 4 2 7) (5 8 4 1 3 6 2 7) (4 2 5 8 6 1 3 7) (4 6 1 5 2 8 3 7) (6 3 1 8 5 2 4 7) (5 3 1 6 8 2 4 7) (4 2 8 6 1 3 5 7) (6 3 5 7 1 4 2 8) (6 4 7 1 3 5 2 8) (4 7 5 2 6 1 3 8) (5 7 2 6 3 1 4 8))

;; breadth first search for N-Queen
;;
; (define (breadth-first-search n)
;   (letrec ((lst (node-expand n '()))
;     (solution '())
;     (x '())
;     (cnt 0)
;     (pop (lambda () (let ((y (car lst)))
;       (set! lst (cdr lst)) y)))
;     (enqueue (lambda (y)
;   (set! lst (append lst y))))
;     (search (lambda ()
;       (if (null? lst) solution
;         (begin (set! x (pop))
;           (display "lst= ")(display lst)
;           (display " x= ") (display x) (newline)
;           (if (safe? x) 
;           (begin
;             (display "safe")(newline)
;             (if (goal? x n)
;               (begin
;               (display "goal")(newline)
;               (set! solution (cons x solution))
;               (set! cnt (+ cnt 1))
;               (display "cnt= ")(display cnt)
;               (enqueue (node-expand n x))))))
;         (search))))))
;       (search)))
(define (breadth-first-search n)
  (letrec ((lst (node-expand n '()))
           (solution '())
           (x '())
           (cnt 0) ;; Add cnt variable
           (sum 0) ;; Add cnt variable
           (pop (lambda () (let ((y (car lst)))
                             (set! lst (cdr lst)) y)))
           (enqueue (lambda (y)
                      (set! lst (append lst y))))
           (search (lambda ()
                     (if (null? lst) 
                         (begin
                          ;  (display "Final cnt value: ")
                          ;  (display cnt)
                           (display "Final sum value: ")
                           (display sum)
                           (newline)
                           solution)
                         (begin
                           (set! x (pop))
                           (display "lst= ")(display lst)
                           (display " x= ") (display x) (newline)
                           ;set! cnt (+ cnt 1))
                           (set! sum (+ sum (length lst)))
                           (if (safe? x)
                               (if (goal? x n)
                                   (set! solution (cons x solution))
                                   (begin
                                     
                                     (enqueue (node-expand n x))))
                               )
                           (search))))))
    (search)))


;Compare the depth-first search and breadth-first search by solving 8-queen. Compare the number of loop count by adding local variable cnt: (let ((cnt 0) .. (search .. (begin .. (set! cnt (+ cnt 1))
