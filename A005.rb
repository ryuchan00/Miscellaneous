class PaizaBowl
  
  def initialize(frames, pins)
    @frames = frames
    @pins = pins

    @pins = Array.new(@frames + 1)
    @frame = 1
  end
  
  def start(pins)
    p pins
    throw = 1
    previous_pin = 0
    one_frame = Array.new
    
    pins.each do |pin|
      one_frame.push(pin)
      if spare?(pin, previous_pin, throw)
        p @frame.to_s + " is spare"
      end
      if strike?(pin, throw)
        p @frame.to_s + " is strike"
        throw += 1
      end
      # if final_frame?
      #   p @frame.to_s + " is final_frame"
      # end
      if throw >= 2
        @pins[@frame] = one_frame
        one_frame = []
        throw = 0
        previous_pin = 0
        @frame += 1
      else
        previous_pin = pin
      end
      throw += 1
    end
  end
  
  def total
    p @pins
    return @pins.inject(:+)
  end
  
  private
  
  def final_frame?
    return @frame == @frames ? true : false
  end
  
  def strike?(pin, throw)
    return (pin == 10) && (throw == 1) ? true : false
  end

  def spare?(pin, previous_pin, throw)
    return (pin + previous_pin == 10) && (throw >= 2) ? true : false
  end
end

a, b, c = gets.chomp.split(" ").map(&:to_i)
p = gets.chomp.split(" ").map(&:to_i)

game = PaizaBowl.new(a, b)
game.start(p)
puts game.total
exit()
