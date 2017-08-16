class FactorizationInPrimeNumbers

# 引数初期化
  def initialize(input)
    if input =~ /^[0-9]+$/ then
      @inputNum = input.to_i
      @primeNumbers = prime(@inputNum)
      @result = []
    else
      puts "引数が整数ではありません。"
      exit()
    end
  end

  def getInputNum
    return @inputNum
  end

  # 素因数分解実行
  def calculate(num)
    if @primeNumbers
      for i in 0..@primeNumbers.size - 1 do
        if num == @primeNumbers[i]
          @result.push(@primeNumbers[i])
          break
        end
        if num.to_f / @primeNumbers[i].to_f === num.to_i / @primeNumbers[i].to_i
          @result.push(@primeNumbers[i])
          # 回帰処理
          calculate(num.to_i / @primeNumbers[i].to_i)
          break
        end
      end
    end
    return @result
  end

  # 素数配列作成
  def prime(num)
    if num === 1
      return false
    end
    primeArray = []
    (2..num).each do |n|
      res = (2..Math.sqrt(n)).any? { |i| n % i == 0 }
      if !res then
        # 素数を配列に格納
        primeArray.push(n)
      end
    end
    return primeArray
  end

end

fa = FactorizationInPrimeNumbers.new(ARGV[0])
num = fa.getInputNum
result = fa.calculate(num)
p result
