class GhostLeg

  def initialize(length, vertical_bar, horizontal_bar)
    @length = length
    @v_bar = vertical_bar
    @h_bar = horizontal_bar
    @ghost_leg = Array.new(@length + 1).map{ Array.new(@v_bar + 1) } # 実際のインプットの番号に沿ったものを使う
  end

  def generate(array_of_bar)
    array_of_bar.each do |bar|
      @ghost_leg[bar[1]][bar[0]] = [bar[2], bar[0] + 1]
      @ghost_leg[bar[2]][bar[0] + 1] = [bar[1] ,bar[0]]
    end
    # @ghost_leg.each { |f| p f}
  end

  def trace
    y = @length
    x = 1
    while y > 0
      unless @ghost_leg[y][x].nil?
        y, x = @ghost_leg[y][x]
      end
      y -= 1
    end
    return x
  end
end


if __FILE__ == $0
  length, vertical_bar, horizontal_bar = gets.split.map(&:to_i)
  array_of_bar = Array.new()
  while s = gets
    array_of_bar.push(s.split.map(&:to_i))
  end

  gl = GhostLeg.new(length, vertical_bar, horizontal_bar)
  gl.generate(array_of_bar)
  puts gl.trace
end
