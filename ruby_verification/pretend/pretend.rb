# https://docs.ruby-lang.org/ja/latest/method/Module/i/prepend.html
# super と prepend の組み合わせの例
module X
  p 'module X'
  def foo
    puts "X1" # (1x)
    super # (2x)
    puts "X2" # (3x)
  end
end

class A
  p 'Class S'

  def foo
    puts "A" #(1a)
  end
  include X
end

a = A.new
a.foo
# (1x) (2x)(ここの super で A#foo を呼びだす) (1a) (3x) の順に実行される
# >> X1
# >> A
# >> X2

