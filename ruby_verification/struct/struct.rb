# パーフェクトRubyより抜粋
Human = Struct.new(:age, :gender)

# Humaオブジェクトを作ってフィールドへアクセスする
human = Human.new(10, 'male')
p human.age
p human.gender
p human.age

# ハッシュライクな使い方
p human[:age]
p human[:age] = 100
p human[:age]

# フィールド一覧を得る
p Human.members
p human.members

# 構造体の各フィールドに対して繰り返し処理を行うことができる。
# StructはEnumberableをincludeしているため、Enumberableで提供しているメソッドも呼び出せる
Foo = Struct.new(:one, :two, :three)
foo = Foo.new('a', 'b', 'c')
p foo

# 各フィールドの値を出力する
foo.each { |value| puts value }

# フィールド名の配列
p foo.members

# フィールド名とペアで繰り返す
foo.each_pair { |field, value| puts field, value }

# プロックを実行した結果の配列を得る
foo.map { |value| value.upcase }

# Structオブジェクトからハッシュを得る
 p Hash[foo.each_pair.to_a]
