require 'gr/plot'

def nCr(n, r)
  bunshi = ((n - r + 1)..n).inject(:*)
  bunbo = (1..r).inject(:*)
  Rational(bunshi, bunbo)
end
N = (2..50).to_a
sums = []
N.each do |i|
  sum = 0.0
  # formulation = []
  (1..i).each do |j|
    member = nCr(i, j) * (Rational(1.0, i)**j) * ((Rational(1.0) - Rational(1.0, i))**(i - j))
    # puts member
    # formulation << member
    sum += member
  end
  # puts formulation.join(' + ')
  # puts formulation.sum
  sum = sum.round(3)
  puts "N=#{format('%3d', i)}のとき #{sum}"
  sums << sum
end

opts = { title: 'PIM throughput',
         ylabel: 'Switch throughput',
         xlabel: 'Switch size, n',
         backgroundcolor: 0 }
GR.plot(N, sums, opts)
GR.savefig('figure.png')
