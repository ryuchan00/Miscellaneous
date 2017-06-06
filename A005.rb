class PaizaBowl
  
  def initialize(frames, pin)
    @frames = frames
    @pin = pin

    @pins = Array.new(@frames + 1)
    @frame = 1
  end
  
  def start(pins)
    throw = 1
    one_frame = Array.new
    
    pins.each do |pin|
      one_frame.push(pin)
      if !final_frame? then
        if strike?(pin, throw)
          throw += 1
        end
        if throw == 2
          @pins[@frame] = one_frame
          one_frame = []
          throw = 0
          @frame += 1
        end
      end
      throw += 1
    end
    @pins[@frame] = one_frame
  end
  
  def add_bonus
    @frame = 0
    @pins.each do |v|
      if v == nil
        next
      end
      @frame += 1
      if final_frame? then
        case
        when v[0] == @pin && v[1] == @pin
          @pins[@frame].push(v[1] + v[2] * 2)
        when v[0] == @pin
          @pins[@frame].push(v[1] + v[2])
        when v[0] >= 1 && v[1] >= 1 && v[0] + v[1] == @pin
          @pins[@frame].push(v[2])
        end
      else
        if strike?(v[0], v.size)
          if strike?(@pins[@frame + 1][0], @pins[@frame + 1].size) then
            @pins[@frame].push(@pins[@frame + 1][0] + @pins[@frame + 2][0])
          else
            @pins[@frame].push(@pins[@frame + 1][0] + @pins[@frame + 1][1])
          end
          next
        end
        if spare?(v.inject(:+), v.size)
          @pins[@frame].push(@pins[@frame + 1][0])
          next
        end
      end
    end
  end
  
  def total
    @pins.compact!
    # return @pins.inject(:+)
    return @pins.inject(0) { |sum ,i| sum + i.inject(:+)}
  end
  
  private
  
  def final_frame?
    return @frame == @frames ? true : false
  end
  
  def strike?(pin, throw)
    return (pin == @pin) && (throw == 1) ? true : false
  end

  def spare?(pins_total, throw)
    return (pins_total == @pin) && (throw == 2) ? true : false
  end
end

a, b, c = gets.chomp.split(" ").map(&:to_i)
p = gets.chomp.split(" ").map(&:to_i)

game = PaizaBowl.new(a, b)
game.start(p)
game.add_bonus
puts game.total
exit()
