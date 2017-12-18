class Ruler
  attr_accessor :length

  def self.pair
    [new, new]
  end
end

# 2つのRulerオブジェクトを返す
p Ruler.pair # [#<Ruler:0x007fd43f80f6b8>, #<Ruler:0x007fd43f80f668>]
