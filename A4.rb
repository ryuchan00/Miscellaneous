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

def hanoi(n, a, b, dst) # n個の石板をsrcからdstへ移動
  if n == 1
    puts("move #{n}-disc from #{src} to #{dst}")
  else
    hanoi(n-1, src, dst, tmp) # n-1個の石板をsrcからtmpへ移動
    puts("move #{n}-disc from #{src} to #{dst}")
    hanoi(n-1, tmp, src, dst) # n-1個の石板をtmpからdstへ移動
  end
end


n = read_header.to_i
cnt = n.to_i
hanoi(cnt, "Left", "Center", "Right")

# puts recursive(n)
# exit(0)
