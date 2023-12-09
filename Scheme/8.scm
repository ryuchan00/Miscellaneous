; 8の課題をやる
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
;(write 'A)   (write '=>)   (write A) (newline)
;(write 'B)   (write '=>)   (write B) (newline)
;(write 'AUB)   (write '=>)   (write (set-union A B)) (newline)
;(write 'A^B)   (write '=>)   (write (set-intersection A B)) (newline)
;(write 'A-B)   (write '=>)   (write (set-diff A B)) (newline)
;(write 'B-A)   (write '=>)   (write (set-diff B A)) (newline)
;(write '((A-B)U(B-A))) (write '=>)(write (set-union (set-diff A B)(set-diff B A))) (newline)
;(write '((AUB)-(A^B))) (write '=>)(write (set-diff (set-union A B) (set-intersection A B))) (newline)

(define Y 
  (lambda (f) 
    ((lambda (h)(h h)) 
      (lambda (p) 
        (f (lambda (n)((p p) n)))))))

(define fib0 
  (lambda (f) 
    (lambda (n) 
      (if (<= n 2) 
        1 
        (+ (f (- n 1))(f (- n 2)))))))

(define fib1
    (lambda (n) 
      (if (<= n 2) 
        1 
        (+ (fib1 (- n 1))(fib1 (- n 2))))))

(define (myeval exp env)
  (cond ((number? exp) exp)
    ((symbol? exp) (assoc* exp env))
    ((eq? (car exp) 'quote*) (cadr exp)) ;; (quote* exp)
    ((eq? (car exp) 'cond*) (eval-cond (cdr exp) env))
    ((eq? (car exp) 'setq*) (eval-setq (cdr exp) env))
    ((eq? (car exp) 'defun*) (eval-defun (cdr exp) env))
    ((eq? (car exp) 'env*) *environment*)
    (else (myapply (car exp) ;; (eq* 3 5)
      (eval-args (cdr exp) env) env))))

(define *environment* '())
(define (init-environment) (set! *environment* '((t . t) (nil . nil))))

(define (assoc* x y)
  (cond ((null? y) (error-message x) '())
    ((equal? x (caar y)) (cdar y))
    (else (assoc* x (cdr y)))))

(define (myapply func args env)
  (cond
    ((symbol? func)
      (cond
        ((eq? func 'car*) (caar args))
        ((eq? func 'cdr*) (cdar args))
        ((eq? func 'cons*) (cons (car args) (cadr args)))
        ((eq? func 'atom*) (myatom? (car args)))
        ((eq? func 'eq*) (myeq? (car args) (cadr args)))
        (else (myapply (myeval func env) args env))))
    ((eq? (car func) 'lambda*) ;; (lambda* (x) (car* x))
      (myeval (caddr func) (bindlist (cadr func) args env)))
    (else (error-message args))))

(define (eval-args exp env)
  (if (null? exp) '()
    (cons (myeval (car exp) env)
      (eval-args (cdr exp) env))))

(define (bindlist vars args env)
  (if (or (null? vars) (null? args)) env
    (append (bd vars args) env)))

(define (bd vars args)
  (if (or (null? vars) (null? args)) '()
    (cons (cons (car vars) (car args))
      (bd (cdr vars) (cdr args)))))

(define (eval-cond con env)
  (cond ((null? con) 'nil)
    ((eq? (myeval (caar con) env) 'nil)
      (eval-cond (cdr con) env))
    (else (myeval (cadar con) env))))

(define (eval-defun exp env)
  (let ((name (car exp))
    (args (cadr exp))
    (body (caddr exp)))
    (set! *environment*
    (cons `(,name . (lambda* ,args ,body))
      env))
        name))

(define (eval-setq exp env)
  (let ((var (car exp))
    (val (myeval (cadr exp) env)))
      (set! *environment*
        (cons (cons var val) env)) val))

(define *prompt* ">> ")
(define *version* "mylisp ver.0.1")

(define (mylisp)
  (display *version*) (newline)
  (init-environment)
  (display *prompt*)
  (do ((exp (read) (read)))
    ((and (list? exp)
      (member (car exp) '(bye* quit* end* exit*)))
    'good-bye)
  (display (myeval exp *environment*))
  (newline)
  (display *prompt*)))

(define (myapply func args env)
  (cond
    ((symbol? func)
      (cond
        ((eq? func 'car*) (caar args))
        ((eq? func 'cdr*) (cdar args))
        ((eq? func 'cons*) (cons (car args) (cadr args)))
        ((eq? func 'atom*) (myatom? (car args)))
        ((eq? func 'eq*) (myeq? (car args) (cadr args)))
        (else (myapply (myeval func env) args env))))
      ((eq? (car func) 'lambda*) ;; (lambda (x) (car* x))
        (myeval (caddr func) (bindlist (cadr func) args
        env)))
      (else (error-message args))))

(define (eval-args exp env)
  (if (null? exp) '()
    (cons (myeval (car exp) env)
      (eval-args (cdr exp) env))))

(define (myeval exp env)
  (cond ((number? exp) exp)
    ((symbol? exp) (assoc* exp env))
    ((eq? (car exp) 'quote*) (cadr exp)) ;; (quote* exp)
    ((eq? (car exp) 'cond*) (eval-cond (cdr exp) env))
    ((eq? (car exp) 'setq*) (eval-setq (cdr exp) env))
    ((eq? (car exp) 'defun*) (eval-defun (cdr exp) env))
    ((eq? (car exp) 'env*) *environment*)
    (else (myapply (car exp) (eval-args (cdr exp) env) env))))

;(car* (cons* 1 (cons* 2 (quote* (3)))))
;(car* quote* (a b c))
;(car* (quote* (a b c)))