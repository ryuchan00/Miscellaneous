(define *database*
  '((likes satoru keiko) (likes satoru apple) (likes keiko book) (likes keiko apple)))

(define (query pattern data)
  (cond
    ((null? pattern) '()) ; Successful match
    ((null? data) '())    ; No more data to match
    ((equal? (car pattern) (car data))
     (query (cdr pattern) (cdr data))) ; Continue matching
    ((and (pair? (car pattern)) (eq? (caar pattern) '?))
     (cons (cons (cdar pattern) (car data))
           (query (cdr pattern) (cdr data)))) ; Variable binding
    (else '()))) ; Match failed

(define (match? pattern database)
  (not (null? (query pattern database))))

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

(define (answer pattern)
  (let ((substitutions (query pattern *database*)))
    (let ((result (filter (lambda (inst-pattern)
                            (match? inst-pattern *database*))
                          (map (lambda (substitution)
                                 (replace-variables pattern substitution))
                               substitutions))))
      (if (null? result)
          '() ;; return an empty list if no matches
          result))))

;; テスト
(display (answer '(likes satoru (? x))))
(newline)
