# Threadの使用例
def print_3(id)
  3.times do |i|
    puts "#{id}: #{i}"
    sleep 0.00001
  end
end

t1 = Thread.new {print_3('A')}
t2 = Thread.new {print_3('B')}

t1.join; t2.join

__END__
B: 0
B: 1
A: 0
B: 2
A: 1
A: 2
