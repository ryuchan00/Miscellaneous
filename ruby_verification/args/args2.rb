# 可変長引数の挙動についての確認
def greet(name, *messages)
  p messages #[[{:a=>1, :b=>2}], [3, 4]]
  p messages[0] # [{:a=>1, :b=>2}]
end

# greet('name', [a: 1, b: 2], [3, 4])

# オプション引数の挙動についての確認
def greet2(name, **messages)
  p messages # {:id=>3, :type=>4}
  p messages[:id] # 3
  p messages[:no_args] # nil
end

greet2('name', id: 1, type: 2, memo: {body: 'body'})
greet2('name', {id: 3, type: 4, memo: {subject: 'subject'}})
