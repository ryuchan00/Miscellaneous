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

(define (product? E)
  (and (pair? E) (equal? '* (car E))))
(define (make-product x) (cons '* x))

(define (diff-product x E)
  (let* ((arg-list (args E))
    (nargs (length arg-list)))
  (cond ((equal? 0 nargs) 0)
    ((equal? 1 nargs) (d x (car arg-list)))
    (else (diff-product-args x arg-list)))))

(define (diff-product-args x arg-list)
  (let* ((E1 (car arg-list))
    (EP (make-product (cdr arg-list)))
    (DE1 (d x E1))
    (DEP (d x EP))
    (term1 (make-product (list DE1 EP)))
    (term2 (make-product (list E1 DEP))))
  (make-sum (list term1 term2))))

(define (simplify E)
  (cond ((sum? E) (simplify-sum E))
    ((product? E) (simplify-product E))
    ((exp? E) (simplify-exp E))
    (else E)))

(define (simplify-sum E)
  (simpl sum? make-sum 0 E))
(define (simplify-product E)
  (simpl product? make-product 1 E))

(define (simpl op? make-op id E)
  (let* ((u (args E))
    (v (map simplify u))
    (w (flat op? v))
    (x (remove-if (lambda (z) (equal? id z)) w))
    (y (proper make-op id x)))
  y))

(define (flat op? x)
  (cond ((null? x) ())
    ((op? (car x))
    (append (args (car x)) (flat op? (cdr x))))
    (else (cons (car x) (flat op? (cdr x))))))
(define (proper make-op id x)
  (cond ((null? x) id)
    ((null? (cdr x)) (car x))
    (else (make-op x))))
(define (remove-if f x)
  (cond ((null? x) ())
    ((f (car x)) (remove-if f (cdr x)))
    (else (cons (car x) (remove-if f (cdr x))))))

(define (exp? E)
  (and (pair? E) (equal? '** (car E))))

(define (diff-exp x E)
  (let* ((arg-list (args E))
    (nargs (length arg-list)))
  (cond ((equal? 0 nargs) 0)
    ((equal? 1 nargs) (d x (car arg-list)))
    (else (diff-product-args x arg-list)))))

(define (simplify-exp E)
  (if (sum? E)
      (let* ((terms (args E))
             (simplified-terms (map simplify-exp terms))
             (non-zero-terms (remove-zero-terms simplified-terms))
      )
      (if (null? non-zero-terms)
          0
          (make-sum non-zero-terms)
      )
      )
      (if (product? E)
          (let* ((terms (args E))
                 (simplified-terms (map simplify-exp terms))
                 (constant-factor (foldl product-constants 1 simplified-terms))
                 (variable-terms (remove-constants simplified-terms))
          )
          (if (= constant-factor 1)
              (if (null? variable-terms)
                  1
                  (if (null? (cdr variable-terms))
                      (car variable-terms)
                      (make-product variable-terms)
                  )
              )
              (if (null? variable-terms)
                  constant-factor
                  (make-product (cons constant-factor variable-terms)
                  )
              )
          )
          )
          E
      )
  )
)

(define (remove-zero-terms terms)
  (filter (lambda (term) (not (= term 0))) terms))

(define (remove-constants terms)
  (filter (lambda (term) (not (constant? term))) terms))

(define (product-constants a b)
  (* a b))

; (define (diff-exp x E)
;   (if (exp? E)
;     (let ((base (cadr E))
;       (exponent (caddr E)))
;     (if (variable? base)
;       (make-product (list exponent (make-product (list '** base (- exponent 1)))))
;       0))
;     (error "diff-exp: expression is not an exponent")))

(define (d x E)
  (cond ((constant? E) (diff-constant x E))
    ((variable? E) (diff-variable x E))
    ((sum? E) (diff-sum x E))
    ((product? E) (diff-product x E))
    ((exp? E) (diff-exp x E))
    (else (error "d: cannot parse" E))))

;実際
;(d 'x '(+ (** x 3) (* 2 (** x 2)) (* 3 (** x 1)) 4))
;=>
;(+ (* 3 (** x 2)) (+ (* 0 (* (** x 2))) (* 2 (* 2 (** x 1)))) (+ (* 0 (* (** x 1))) (* 3 (* 1 (** x 0)))) 0)
;初期バージョン
;(+ (* 3 (* ** x 2)) (+ (* 0 (* (** x 2))) (* 2 (* 2 (* ** x 1)))) (+ (* 0 (* (** x 1))) (* 3 (* 1 (* ** x 0)))) 0)
;(+ (* 3 (* ** x 2)) (+ (* 0 (* (** x 2))) (* 2 (* 2 (* ** x 1)))) (+ (* 0 (* (** x 1))) (* 3 (* 1 (* ** x 0)))) 0)

;理想
;(d 'x '(+ (** x 3) (* 2 (** x 2)) (* 3 (** x 1)) 4))
;=>
;(+ (* 3 (** x 2)) (+ (* 0 (* (** x 2))) (* 2 (* 2 (** x 1)))) (+ (* 0 (* x)) (* 3 1)) 0)

;18ページのブロックワールドの問題で、初期状態から「((on c b) (on b a) (on a table) (clear c))」までのルール選択の順序を答えなさい。プログラムを実行して順序を確認しなさい。

#|
前方推論（または前方推論）は、推論エンジンを使用するときの推論の2つの主要な方法の1つであり、モダスポネンスの繰り返し適用として論理的に記述することができます。フォワード・チェイニングは、エキスパート・システム、ビジネス・ルール・システム、プロダクション・ルール・システムのための一般的な実装戦略である。フォワード・チェイニングの反対は、バックワード・チェイニングである。

フォワード・チェイニングは、利用可能なデータから始まり、ゴールに到達するまで、推論ルールを使って（例えばエンドユーザーから）さらにデータを抽出する。前方連鎖を使用する推論エンジンは、先行詞（If節）が真であることが分かっているものが見つかるまで、推論ルールを検索する。そのようなルールが見つかると、エンジンは帰結（Then節）を推論することができ、その結果、データに新しい情報が追加される[1]。

|#

#|
5 error> (forward-reasoning *working-memory*)
enable rules : (rule9 rule7 rule3 rule2)
enter rule-name >> rule3
 *working-memory* : ((on c table) (on a table) (clear b) (on b table) (clear a) (clear c))
enable rules : (rule9 rule8 rule7 rule6 rule5 rule4 rule3 rule2 rule1)
enter rule-name >> rule7
 *working-memory* : ((on b c) (on c table) (on a table) (clear b) (clear a))
enable rules : (rule6 rule4 rule2 rule1)
enter rule-name >> rule4
 *working-memory* : ((on a b) (on b c) (on c table) (clear a))
enable rules : (rule1)
|#

#|
rule3
rule7
rule4
|#

; global variable definition
; rule base and access function
(define *rule-base* '())
; r: (rule-name condtion --> action)
(define (get-rulename r) (car r))
(define (get-cond r) (cadr r))
(define (get-action r) (cadddr r))
; working memory
(define *working-memory* '())


(define (rule-cond? conds states)
(cond ((null? conds) #t)
((eq? (car conds) 'and)
(condition-aux? (cdr conds) states))
(else (element? conds states))))

(define (condition-aux? conds states)
(cond ((null? conds) #t)
((element? (car conds) states)
(condition-aux? (cdr conds)
states))
(else #f)))
(define (element? x a)
(cond ((empty? a) #f)
((equal? x (car a)) #t)
(else (element? x (cdr a)))))
(define (empty? a) (null? a))

; ask user to select
(define (choice rlist)
(cond ((null? rlist) '())
(else (printn "enable rules : " rlist)
(display "enter rule-name >> ")
(read))))
;
(define (rule-action! rname memory)
(let ((rule (get-rule rname *rule-base*)))
(if (null? rule) memory
(eval-action (get-action rule) memory))))
(define (get-rule rname rules)
(if (null? rules) '()
(let ((rule (car rules)))
(if (eq? (car rule) rname) rule
(get-rule rname (cdr rules))))))

(define (eval-action action memory)
(set! memory (cons action memory))
(printn "action : " action)
memory)


;後方推論プロダクションシステム "pattern-matching-back "と "eval-action-back "の2つの機能を、P.24の旅行相談シナリオでプログラムを実行することによって追跡しなさい。eval-action-back "が何をしているか説明しなさい。


; backward inference
(define (backward-reasoning memory)
(do
((rule (choice (pattern-matching-back
memory))
(choice (pattern-matching-back
memory))))
((or (null? rule)
(eq? rule 'quit)) 'end)
(set! memory (rule-action-back rule))
(output-data-back memory)))
(define (output-data-back item)
(if (null? item)
(printn (caar *working-memory*)
" is unsuitable for you.")))

(define (pattern-matching-back states)
(let ((enables '()))
(for-each (lambda (candidate)
(if (rule-cond? (get-action candidate)
states)
(set! enables (cons (get-rulename
candidate) enables))))
*rule-base*)
enables))
(define (rule-action-back r)
(let ((rule (get-rule r *rule-base*)))
(if (null? rule) '()
(let* ((items (get-cond rule))
(item (car items)))
(if (eq? item 'and)
(eval-action-back (cdr items) '())
(eval-action-back (list items)
'()))))))

#|
現在の条件にマッチするルールに関連するアクションを評価する．まずitemsリストが空かどうかをチェックする．空であれば，もう評価する条件がない．pattern-matching-back関数をcallし，itemにマッチするルールを検索し、itemにマッチする条件を持つルール名のリストを返す．見つからない場合は，候補を提示する．ユーザーがそれで問題ないかy or nで答えさせる．もしyだったら，それはlstに追加する．

提供されたコードの eval-action-back 関数は、後方推論システムにおいて、現在の条件にマッチするルールに関連するアクションを評価するために使用されます。以下はその仕組みの説明である：

eval-action-backはitemsとlstの2つの引数を取ります。

eval-action-backはitemsリストが空かどうかをチェックする。空であれば、もう評価する条件がないことを意味し、lst（取るべきアクションを蓄積したもの）を返す。

アイテム・リストが空でなければ、次のステップに進む。

アイテムリストから最初のアイテム（条件）を取り出し、item変数に代入する。

pattern-matching-back関数を呼び出すことで、このitemにマッチするルールを検索し、itemにマッチする条件を持つルール名のリストを返す。

一致するルールが見つからない場合（ルールリストが空である場合）、それは条件が満たされていないことを意味する。次の条件で満足するかどうかをユーザーに尋ねる。ユーザーが'y'と答えた場合、その項目はlst（アクションリスト）に追加される。

一致するルールが見つかれば（ルールリストが空でなければ）、次のステップに進む。

eval-action-backを残りの項目（リストの残りの条件）と更新されたlstで再帰的に呼び出します。これにより、残りの条件を評価し続け、lstにアクションを蓄積することができる。

まとめると、eval-action-backは後方推論システムにおいて、条件の評価とアクションの蓄積を行う。eval-action-backは条件を繰り返し、マッチするルールがないかチェックする。ルールが見つかれば、関連するアクションをlstに追加する。一致するルールが見つからなければ、ユーザーに入力を求める。このプロセスは、すべての条件が評価されるか、ユーザーが満足するまで続けられる。

www.DeepL.com/Translator（無料版）で翻訳しました。
|#
(define (eval-action-back items lst)
(if (null? items) lst
  (let* ((item (car items))
  (rules (pattern-matching-back (list
  item))))
(if (null? rules)
  (if (eq? (question item) 'y)
    (eval-action-back (cdr items) (cons item
    lst))
    '())
    (eval-action-back (cdr items) (cons item
  lst))))))
(define (question lst)
(cond ((null? lst) #f)
(else (printn "Do you feel satisfied next
condition?")
(printn (car lst))
(display "please input 'y' or 'n' >>")
(read))))

(set! *rule-base*
'((rule1 (and (USA) (English)) -->
(Honolulu))
(rule2 (and (Europe) (France)) -
-> (Paris))
(rule3 (and (USA) (Continent)) -
-> (LA))
(rule4 (and (Island) (Equator))
--> (Honolulu))
(rule5 (and (Asia) (Equator)) --
> (Singapore))
(rule6 (and (Island)
(Micronesia)) --> (Guam))
(rule7 (Swimming) -->
(Equator))))

;(set! *working-memory* '((Island) (Swimming)))

#|
> (backward-reasoning *working-memory*)
enable rules : (rule4 rule1)
enter rule-name >> rule4
Do you feel satisfied next condition?
Island
please input 'y' or 'n' >>y
enable rules : (rule7)
enter rule-name >> rule7
Do you feel satisfied next condition?
Swimming
please input 'y' or 'n' >>y
end
#|

;(load "myapp2.scm")
;(backward-reasoning *working-memory*)
(set! *working-memory* '((Honolulu)))