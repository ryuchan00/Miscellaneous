class Coffee
  def initialize
    @water = 0.0
    @powder = 0.0
  end

  def addWater(quantity)
    @water += quantity
  end

  def addPowder(quantity)
    @powder += quantity
  end

  def getTotal
    return @water + @powder
  end

  def taste(quantity)
    total = getTotal
    @water -= quantity * @water / total
    @powder -= quantity * @powder / total
  end

  def getConsentration(asPercent)
    return (@powder / getTotal) * (asPercent ? 100.0 : 1.0)
  end
end

coffee = Coffee.new()

gets.to_i.times {
  arr = gets.split(" ")
  actType = arr[0].to_i
  quantity = arr[1].to_f
  if actType == 1 then
    coffee.addWater(quantity)
  elsif actType == 2 then
    coffee.addPowder(quantity)
  elsif actType == 3 then
    coffee.taste(quantity)
  end
}
puts coffee.getConsentration(true).to_i