# Threadを使用していない例
def print_3(id)
  3.times do |i|
    puts "#{id}: #{i}"
    sleep 0.00001
  end
end

print_3('A')
print_3('B')

# A: 0
# A: 1
# A: 2
# B: 0
# B: 1
# B: 2
