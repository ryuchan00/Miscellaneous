(define (exp? E)
  (and (pair? E) (eq? (car E) '**)))

(define (diff-exp x E)
  (if (exp? E)
      (let ((base (cadr E))
            (exponent (caddr E)))
        (if (variable? base)
            (list '* exponent
                  (list '** base (- exponent 1)))
            0))
      (error "diff-exp: expression is not an exponent")))

(define (d x E)
  (cond ((constant? E) (diff-constant x E))
        ((variable? E) (diff-variable x E))
        ((sum? E) (diff-sum x E))
        ((product? E) (diff-product x E))
        ((exp? E) (diff-exp x E))
        (else (error "d: cannot parse" E)))
)

(define (constant? E)
  (number? E))

(define (variable? E)
  (symbol? E))

(define (sum? E)
  (and (pair? E) (eq? (car E) '+))
)

(define (product? E)
  (and (pair? E) (eq? (car E) '*))
)

(define constant? number?)
(define (diff-constant x E) 0)
(define variable? symbol?)
(define (diff-variable x E)
(if (equal? x E) 1 0))
(define (sum? E)
(and (pair? E) (equal? '+ (car E))))
(define (args E) (cdr E))
(define (make-sum x) (cons '+ x))
(define (diff-sum x E)
(make-sum
(map (lambda (expr) (d x expr)) (args E))))