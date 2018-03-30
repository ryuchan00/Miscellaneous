# cattr_accessor は rubyのライブラリではなく、activesupportのメソッド
class Parent
  cattr_accessor :foo
end
class Child < Parent
end
class Grandchild < Child
end
Parent.foo = 100
Child.foo #=> 100
Child.foo = 200
Child.foo #=> 200
Parent.foo #=> 200     // 値は継承ツリーの上位に反映される
Grandchild.foo #=> 200 // 値は継承ツリーの下位に反映される
