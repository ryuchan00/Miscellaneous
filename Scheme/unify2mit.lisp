;;
;; (get-var '(?alpha . beta)) ==> ?alpha
(define (get-var binding)
  (if (null? binding) binding
        (car binding)))
;;
;; (get-val '((? alpha) . beta)) ==> beta
(define (get-val binding)
  (if (null? binding) binding
        (cdr binding)))
;;
;;
(define (get-binding var theta)
  (let ((result (assoc var theta)))
    (if result result '())))
;;
;;
(define (make-binding var val)
  (cons var val))
;;
;;
(define (occur-check? var exp)
  (cond ((const? exp) #t)
        ((var? exp) (if (equal? var exp) #f #t))
        ((occur-check? var (car exp))
         (occur-check? var (cdr exp)))
        (else #f)))
;;
(define (var? atom)
  (and (symbol? atom) (eq? #\? (string-ref (symbol->string atom) 0))))
(define (const? atom)
  (and (not (var? atom)) (not (pair? atom))))
;;
;; (instantiate '((? x) (? y)) '(((? x) . 1)((? y) . 2))) 
;; => (1 2)
;;
(define (instantiate exp subst)
;;       (write "exp:")(write exp) (newline)
;;       (write "subst:")(write subst) (newline)
  (cond ((null? exp) '())
        ((eq? subst 'failed) exp)
        ((const? exp) exp)
        ((var? exp)
         (let* ((bind (get-binding exp subst))
                (result (get-val bind)))
           (if (null? bind) exp result)))
        (else (cons (instantiate (car exp) subst)
                    (instantiate (cdr exp) subst)))))
;;
(define (inst2 exp subst)
  (cond ((const? exp) exp)
        ((var? exp)
         (let* ((bind (get-binding exp subst))
                (result (get-val bind)))
           (if (null? bind) exp (inst2 result subst))))
        (else (cons (inst2 (car exp) subst)
                    (inst2 (cdr exp) subst)))))
;;
;; theta.ihta = rho
;; (subst-compose '(((? x) . a) ((? z) . (f (? y))))
;;                '(((? x) . b) ((? y) . c)))
;; => (((? y) . c) ((? z) f c) ((? x) . a))
;;
(define (subst-compose theta eta)
  (letrec
    ((rho '())
     (compose-a (lambda (var val)
       (let ((new (instantiate val eta)))
         (if (not (equal? var new))
             (set! rho (cons (make-binding var new) rho))))))
     (compose-b (lambda (var val)
       (let ((foo (get-binding var theta)))
         (if (null? foo)
             (set! rho (cons (make-binding var val) rho)))))))
   (for-each
      (lambda (x) (compose-a (get-var x) (get-val x)))
      theta)
   (for-each
      (lambda (x) (compose-b (get-var x) (get-val x)))
      eta)
   rho))
;;
;;
(write `(subst-compose ((?x . a) (?z . (f ?y)))
                       ((?x . b) (?y . c))))
(write '=>)
(newline)
(write (subst-compose '((?x . a) '(?z . (f ?y)))
                      '((?x . b) (?y . c))))
(newline)
;;
;;
(define (unify3 p q theta)
;;       (write "p:")(write p) (newline)
;;       (write "q:")(write q) (newline)
;;       (write "t:")(write theta) (newline)
    (cond
       ((eq? theta 'failed) 'failed)
       ((and (var? p) (occur-check? p q)
          (subst-compose theta `(,(make-binding p q)))))
       ((var? p) 'failed)
       ((and (var? q) (occur-check? q p))
        (subst-compose theta `(,(make-binding q p))))
       ((var? q) 'failed)
       ((const? p)
          (if (const? q)
            (if (equal? p q) theta
                'failed)
             'failed))
        ((const? q) 'failed)
        (else (unify3 (cdr p) (cdr q)
              (unify3 (instantiate (car p) theta)
                         (instantiate (car q) theta)
                          theta)))))
;;
(define (unify p q)
  (unify3 p q '()))
;;
;; now test the unify 
(define U1 '(unify '(?x) '(1)))
(define U2 '(unify '(1 ?x 3 4 ?z) '(1 2 ?y 4 5)))
(define U3 '(unify '(?x 2 4) '((1 ?x) ?y 4)))
(define U4 '(unify '(?x (f ?y)) '(b (f ?z))))
(define U5 '(unify '(?x a (f ?z)) '((g ?y) ?y ?w)))
(define U6 '(unify '(f (x y) + g (n m)) '(f ?a + g ?b)))
;;
(write U1) (write '=>) (write (eval U1 user-initial-environment)) (newline)
(write U2) (write '=>) (write (eval U2 user-initial-environment)) (newline)
(write U3) (write '=>) (write (eval U3 user-initial-environment)) (newline)
(write U4) (write '=>) (write (eval U4 user-initial-environment)) (newline)
(write U5) (write '=>) (write (eval U5 user-initial-environment)) (newline)
(write U6) (write '=>) (write (eval U6 user-initial-environment)) (newline)
;;
;; finally instantiate the result
(write `(instantiate ,(cadr U1) and ,(caddr U1))) (write '=>) 
(write (instantiate (cadr U1) (eval U1 user-initial-environment))) (newline)          
(write `(instantiate ,(cadr U2) and ,(caddr U2))) (write '=>) 
(write (instantiate (cadr U2) (eval U2 user-initial-environment))) (newline)          
(write `(instantiate ,(cadr U3) and ,(caddr U3))) (write '=>) 
(write (instantiate (cadr U3) (eval U3 user-initial-environment))) (newline)          
(write `(instantiate ,(cadr U4) and ,(caddr U4))) (write '=>) 
(write (instantiate (cadr U4) (eval U4 user-initial-environment))) (newline)          
(write `(instantiate ,(cadr U5) and ,(caddr U5))) (write '=>) 
(write (instantiate (cadr U5) (eval U5 user-initial-environment))) (newline)          
(write `(instantiate ,(cadr U6) and ,(caddr U6))) (write '=>) 
(write (instantiate (cadr U6) (eval U6 user-initial-environment))) (newline)    
     
(define *database*
'((likes satoru keiko) (likes satoru apple) (likes keiko book) (likes keiko apple)))

(define (query pattern)
  (define (match pattern data)
    (cond
      ((null? pattern) '())
      ((null? data) '())
      ((equal? (car pattern) (car data))
       (match (cdr pattern) (cdr data)))
      ((and (pair? (car pattern)) (equal? (caar pattern) '?))
       (cons (cons (cdar pattern) (car data))
             (match (cdr pattern) (cdr data))))
      (else '())))
  (let ((results '()))
    (let loop ((db *database*))
      (cond
        ((null? db) results)
        (else
          (let ((match (match pattern (car db))))
            (if (not (null? match))
                (set! results (append results match)))
            (loop (cdr db))))))))

(define (answer pattern)
  (let ((substitutions (query pattern)))
    (map (lambda (substitution)
           (let ((instantiated-pattern (replace-variables pattern substitution)))
             (if (match? instantiated-pattern *database*)
                 instantiated-pattern
                 '())))
         substitutions)))

(define (replace-variables pattern substitution)
  (if (null? pattern)
      '()
      (let ((item (car pattern)))
        (if (pair? item)
            (let ((var (car item)))
              (if (symbol? var)
                  (cons (cons (cdr item) (cdr (assoc var substitution)))
                        (replace-variables (cdr pattern) substitution))
                  (cons item (replace-variables (cdr pattern) substitution))))
            (cons item (replace-variables (cdr pattern) substitution))))))

(define (match? pattern database)
  (not (null? (query pattern))))

;; depth first search for N-Queen
;;
; (define (depth-first-search n)
;   (letrec ((lst (node-expand n '()))
;     (solution '())
; (x '())
; (pop (lambda () (let ((y (car lst)))
; (set! lst (cdr lst)) y)))
; (push (lambda (y) (set! lst (append y lst))))
; (search (lambda ()
; (if (null? lst) solution
; (begin (set! x (pop))
; (display "lst= ")(display lst)
; (display " x= ") (display x)
; (newline)
; (if (safe? x)
; (if (goal? x n)
; (set! solution (cons x
; solution))
; (push (node-expand n x))))
; (search))))))
; (search)))

(define (answer pattern)
  (display pattern) ;(likes satoru (? x))
  (display "\n")
  (let ((substitutions (query pattern))) ;(((x) . keiko) ((x) . apple))
    (display substitutions)
    (display "\n")
    (map (lambda (substitution)
          (display "substitution")
          (display substitution)
          (display "\n")
           (let ((instantiated-pattern (replace-variables pattern substitution)))
             (if (match? instantiated-pattern *database*)
                 instantiated-pattern
                 '())))
         substitutions)))

(match? '((likes satoru keiko)) *database*)

(define (replace-variables pattern substitution)
  (if (null? pattern)
      '()
      (let ((item (car pattern)))
        (display "item: ")
        (display item)
        (display "\n")
        (if (pair? item)
            ; (? x)
            (let ((var (car item)))
            ;(display "var: ")
            ;(display var)
            ;(display "\n")
              (if (symbol? var)
                (desiplay "hogehoge"))
                              
  )))))
(define (replace-variables pattern substitution)
  (if (null? pattern)
      '()
      (let ((item (car pattern)))
        (if (pair? item)
            (let ((var (car item)))
              (if (and (symbol? var) (assoc var substitution))
                  (cons (cons (cdr item) (cdr (assoc var substitution)))
                        (replace-variables (cdr pattern) substitution))
                  (cons item (replace-variables (cdr pattern) substitution))))
            (cons item (replace-variables (cdr pattern) substitution))))))


; ; (define (match? pattern database)
; ;   (not (null? (query pattern))))

; (display "hoge")
; (display "\n")

; ;(display (answer '(likes satoru (? x))))


