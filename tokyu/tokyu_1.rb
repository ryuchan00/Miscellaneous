class Divisor

  # 引数初期化
  def initialize(input)
    if input =~ /^[0-9]+$/ then
      @inputNum = input.to_i
    else
      puts "引数が整数ではありません。"
      exit()
    end

  end

  #約数算出
  def calculate
    sum = 0
    for i in 1..@inputNum do
      if @inputNum % i === 0
        sum += i
      end
    end
    return sum
  end

end

di = Divisor.new(ARGV[0])
sum = di.calculate
puts sum.to_s + "\n"
