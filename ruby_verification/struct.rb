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
