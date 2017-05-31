# coding: utf-8

def new_line
  return "\n"
end

def read_header
  return gets.chomp
end

def read_data
  return gets.chomp.split(" ")
end

def hanoi(n, src, tmp, dst, a, b, c) # n個の石板をsrcからdstへ移動
  if n == 1
    puts("move #{n}-disc from #{src} to #{dst}")
    circle = a.shift(1)[0]
    c.unshift(circle)
    @cnt += 1
  else
    hanoi(n-1, src, dst, tmp, a, c, b) # n-1個の石板をsrcからtmpへ移動
    puts("move #{n}-disc from #{src} to #{dst}")
    circle = a.shift(1)[0]
    c.unshift(circle)
    @cnt += 1
    hanoi(n-1, tmp, src, dst, b, a, c) # n-1個の石板をtmpからdstへ移動
  end
end

@cnt = 0
n = read_header.to_i
cnt = n.to_i
ary_init = Array.new
(1..n).each { |v| ary_init << v }
a = ary_init
b = []
c = []
# p POLE
hanoi(cnt, "Left", "Center", "Right", a, b, c)
p a
p b
p c
puts @cnt

# puts recursive(n)
# exit(0)
