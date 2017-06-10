class GhostLeg

  def initialize(length, vertical_bar, horizontal_bar)
    @length = length
    @v_bar = vertical_bar
    @h_bar = horizontal_bar
    @ghost_leg = Array.new(@length + 1).map{ Array.new(@v_bar + 1) } # 実際のインプットの番号に沿ったものを使う
    p @ghost_leg
  end

  def generate(array_of_bar)
    array_of_bar.each do |bar|
      @ghost_leg[bar[1]][bar[0]] = [bar[2], bar[0] + 1]
      @ghost_leg[bar[2]][bar[0] + 1] = [bar[1] ,bar[0]]
    end
    p @ghost_leg
    p "-----"
    @ghost_leg.each { |f| p f}
  end

  def trace
    y = @length
    x = 1
    p y
    p x
    # p @ghost_leg
    p @ghost_leg[y][x]
    while y > 0
      unless @ghost_leg[y][x].nil?
        p @ghost_leg[y][x][0]
        p "y " + y.to_s
        p "x " + x.to_s
        p @ghost_leg[y][x]
        y, x = @ghost_leg[y][x]
        p "y " + y.to_s
        p "x " + x.to_s
        # y -= 1
        # p @ghost_leg[y][x][0]
        # p @ghost_leg[y][x][1]
        # x = @ghost_leg[y][x][1]
        # p x
      end
      y -= 1
    end
    return x
  end

  def throw_one(*array_of_npins)
    p "frame is " + @frame.to_s
    p array_of_npins
    #raiseで例外クラス、メッセージを与えている
    raise ArgumentError, "#{array_of_npins.inspect}" if illegal_throw_one?(array_of_npins)

    record(array_of_npins)
  end

  def total_score
    calculate_score
    @scores.compact.inject(&:+)
  end

  private

    def final_frame?(frame)
      frame == @num_frames
    end

    def strike?(array_of_npins)
      array_of_npins[0] == @num_pins
    end

    def spare?(array_of_npins)
      array_of_npins.size >= 2 && array_of_npins[0] + array_of_npins[1] == @num_pins
    end

    def illegal_throw_one?(array_of_npins)
      array_of_npins.size > 3 || \
      array_of_npins.any? { |npins| npins > @num_pins } || \
      array_of_npins.size <= 2 && array_of_npins.inject(&:+) > @num_pins || \
      array_of_npins.size == 1 && array_of_npins.first != @num_pins
    end

    def record(array_of_npins)
      @pins[@frame] = array_of_npins
    end

    def calculate_score
      @scores = @pins.map { |pin| pin && pin.inject(&:+) }
      1.upto(@num_frames) do |frame|
        add_bonus_for(frame)
      end
    end

    def add_bonus_for(frame)
      if final_frame?(frame)
        add_bonus_for_final_frame
      else
        pins_after = @pins[frame + 1, @pins.size].flatten
        if spare?(@pins[frame])
          @scores[frame] += pins_after[0]
        elsif strike?(@pins[frame])
          @scores[frame] += pins_after[0] + pins_after[1]
        end
      end
    end

    def add_bonus_for_final_frame
      frame = @num_frames
      pins = @pins[frame]
      if spare?(pins)
        @scores[frame] += pins[2]
      elsif strike?(pins)
        @scores[frame] += pins[1] + pins[2]
        if strike?(pins[1, 1])
          @scores[frame] += pins[2]
        end
      end
    end
end


if __FILE__ == $0
  length, vertical_bar, horizontal_bar = gets.split.map(&:to_i)
  array_of_bar = Array.new()
  while s = gets
    array_of_bar.push(s.split.map(&:to_i))
  end
  # array_of_bar.each do |n|
  #   p n
  # end
  p array_of_bar

  gl = GhostLeg.new(length, vertical_bar, horizontal_bar)
  gl.generate(array_of_bar)
  # exit()
  puts gl.trace
end
