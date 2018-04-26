class Foo
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def name
    'shinnosuke'
  end
end

foo = Foo.new('ryutaro')
p foo.name # => "shinnosuke"

