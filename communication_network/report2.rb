def nCr(n, r)
  bunshi = ((n - r + 1)..n).inject(:*)
  bunbo = (1..r).inject(:*)
  Rational(bunshi, bunbo)
end

(2..10).each do |i|
  sum = 0.0
  formulation = []
  (1..i).each do |j|
    member = nCr(i, j) * (Rational(1.0, i) ** j) * ((Rational(1.0) - Rational(1.0, i)) ** (i - j))
    puts member
    formulation << member
    sum += member 
  end
  # puts formulation.join(' + ')
  puts "N=#{sprintf("%3d", i)}  #{sum.round(3)}"
end
