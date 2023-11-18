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
; (define (unify p q)
;   (unify3 p q '()))
; (define (unify-aux (lambda (p q theta)
;         (cond
;         ((eq? theta 'failed) 'failed)
;         ((and (var? p) (occur-check? p q))
;         (subst-compose theta
;           `(,(make-binding p q))))
;         ((and (var? q) (occur-check? q p))
;         (subst-compose theta
;           `(,(make-binding q p))))
;         ((const? p)
;           (if (const? q)
;             (if (equal? p q) theta 'failed) 'failed))
;         ((const? q) 'failed)
;         (else (unify-aux (cdr p) (cdr q)
;           (unify-aux (instantiate (car p) theta)
;           (instantiate (car q) theta)theta)))))))

(define (unify p q)
  (letrec
    ((theta '())
      ; (unify-aux)
      (unify-aux (lambda (p q theta)
        (cond
        ((eq? theta 'failed) 'failed)
        ((and (var? p) (occur-check? p q))
        (subst-compose theta
          `(,(make-binding p q))))
        ((and (var? q) (occur-check? q p))
        (subst-compose theta
          `(,(make-binding q p))))
        ((const? p)
          (if (const? q)
            (if (equal? p q) theta 'failed) 'failed))
        ((const? q) 'failed)
        (else (unify-aux (cdr p) (cdr q)
          (unify-aux (instantiate (car p) theta)
          (instantiate (car q) theta)theta))))))
          )
        (unify-aux p q theta)))
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
     
;(unify-aux p q theta）の前に（trace unify-aux）を挿入するか、「unify-aux」関数をグローバル関数として定義することによって、単一化関数「unify-aux」をトレースする。
;トレース (unify '(1 (? x) 3 4 (? z)) '(1 2 (? y) 4 5))).

;(unify '(1 (? x) 3 4 (? z)) '(1 2 (? y) 4 5)))
;(trace unify)
;(load "unify2mit.scm")
;(trace unify-aux)

(define *database*
'((likes satoru keiko) (likes satoru apple) (likes keiko book) (likes keiko apple)))

(query '(likes satoru (? x))) returns the substitution (((? x) .keiko ) ((? x) . apple))

;p.33に記述されているデータベース照会システムを開発する。以下のように動作するクエリー関数を定義しなさい：(query '(likes satoru (? x))) は置換 (((? x) .keiko ) ((? x) .apple)) を返す。

; (define (query pattern)
;   (define (match pattern data)
;     (cond
;       ((null? pattern) '()) ; Successful match
;       ((null? data) '())    ; No more data to match
;       ((equal? (car pattern) (car data))
;        (match (cdr pattern) (cdr data))) ; Continue matching
;       ((and (pair? (car pattern)) (equal? (caar pattern) '?))
;        (cons (cons (cdar pattern) (car data))
;              (match (cdr pattern) (cdr data)))) ; Variable binding
;       (else '()))) ; Match failed

;   (let ((results '()))
;     (let loop ((db *database*))
;       (cond
;         ((null? db) results)
;         (else
;           (let ((match (match pattern (car db))))
;             (if (not (null? match))
;                 (set! results (append results match)))
;             (loop (cdr db))))))))

;次のように動作するアンサー関数を定義する：(answer '(likes satoru (? x))) インスタンス化された結果 ((likes satoru keiko ) (likes satoru apple )) を返します。

