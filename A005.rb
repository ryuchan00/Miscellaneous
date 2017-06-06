class PaizaBowl
  
  def initialize(frames, pin)
    @frames = frames #フレーム数
    @pin = pin #ピンの数
    @pins = Array.new(@frames + 1) #ゲームスコアの配列
    @frame = 1 #現在のフレーム数
  end
  
  def start(pins)
    throw = 1
    one_frame = Array.new
    
    pins.each do |pin|
      one_frame.push(pin)
      
      next if final_frame?
      
      if strike?(pin, throw)
        throw += 1
      end
      if throw == 2
        @pins[@frame] = one_frame
        one_frame = []
        throw = 0
        @frame += 1
      end
      throw += 1
    end
    @pins[@frame] = one_frame
  end
  
  def add_bonus
    @frame = 0
    @pins.each do |v|
      next if v == nil
      @frame += 1
      if final_frame? then
        case
        #2回連続ストライク
        when strike?(v[0], 1) && strike?(v[1], 1)
          @pins[@frame].push(v[1] + v[2] * 2)
        when strike?(v[0], 1)
          @pins[@frame].push(v[1] + v[2])
        when v[0] >= 1 && v[1] >= 1 && spare?(v[0] + v[1], 2)
          @pins[@frame].push(v[2])
        end
      else
        case
        #2回連続ストライク
        when strike?(v[0], v.size) && strike?(@pins[@frame + 1][0], @pins[@frame + 1].size)
          @pins[@frame].push(@pins[@frame + 1][0] + @pins[@frame + 2][0])
        when strike?(v[0], v.size)
          @pins[@frame].push(@pins[@frame + 1][0] + @pins[@frame + 1][1])
        when spare?(v.inject(:+), v.size)
          @pins[@frame].push(@pins[@frame + 1][0])
        end
      end
    end
  end
  
  def total
    @pins.compact!
    return @pins.inject(0) { |sum ,i| sum + i.inject(:+)}
  end
  
  private
  
  def final_frame?
    return @frame == @frames ? true : false
  end
  
  def strike?(pin, throw)
    return (pin == @pin) && (throw == 1) ? true : false
  end

  def spare?(pins, throw)
    return (pins == @pin) && (throw == 2) ? true : false
  end
end

a, b, c = gets.chomp.split(" ").map(&:to_i)
p = gets.chomp.split(" ").map(&:to_i)

game = PaizaBowl.new(a, b)
game.start(p)
game.add_bonus
puts game.total
