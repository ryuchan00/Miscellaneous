class FactorizationInPrimeNumbers

# 引数初期化
  def initialize(inputFile)
    errorMsg = []
    @primes = []
    @fileData = []
    inputFilePath = File.expand_path(inputFile.to_s)
    if File.exist?(inputFilePath)
      @inputFilePath = inputFilePath
    else
      errorMsg.push(inputFilePath + "は存在しません。")
    end
  end

  def getInputNum
    return @inputNum
  end

  def readFile
    file = File.open(@inputFilePath)
    fileData = file.read
    @fileData = fileData.split("\n").map(&:to_i)
    file.close
  end

  def writeFile
    file = File.open(@inputFilePath, "w")
    @fileData.each do |num|
      calculate(num)
      if @primes.empty? then
        file.write num.to_s + "\n"
      else
        file.write num.to_s + "," + @primes.join(",").to_s + "\n"
      end
      @primes = []
    end
    file.close
  end

  # 素因数分解実行
  def calculate(num)
    # 素数配列作成
    if num <= 1
      puts "「" + num.to_s + "」は素因数分解できません"
      return false
    end
    primeNumbers = []
    (2..num).each do |n|
      res = (2..Math.sqrt(n)).any? { |i| n % i == 0 }
      if !res then
        # 素数を配列に格納
        primeNumbers.push(n)
      end
    end

    # 素因数分解実行
    for i in 0..primeNumbers.size - 1 do
      if num == primeNumbers[i]
        @primes.push(primeNumbers[i])
        break
      end
      if num.to_f / primeNumbers[i].to_f === num.to_i / primeNumbers[i].to_i
        @primes.push(primeNumbers[i])
        # 回帰処理
        calculate(num.to_i / primeNumbers[i].to_i)
        break
      end
    end
  end

  def run
    readFile()
    writeFile()
  end

end

fa = FactorizationInPrimeNumbers.new(ARGV[0])
fa.run
