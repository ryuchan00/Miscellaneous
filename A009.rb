# coding: utf-8

def new_line
  return "\n"
end

def read_header
  return gets.chomp.split(" ")
end

def read_data
  return gets.chomp.split("")
end

TEST = ''

def hanoi(n, src, tmp, dst) # n個の石板をsrcからdstへ移動
  if n == 1
    if TEST == "1"
      puts("move #{n}-disc from #{src} to #{dst}")
    end
    # p discs[0]["Left"]
    # p discs
    circle = @discs[0][src].shift(1)[0]
    @discs[0][dst].unshift(circle)
    # p discs
    @cnt += 1
    if @cnt >= @loop
      display(@discs)
      exit()
    end
  else
    hanoi(n-1, src, dst, tmp) # n-1個の石板をsrcからtmpへ移動
    if TEST == "1"
      puts("move #{n}-disc from #{src} to #{dst}")
    end
    # p discs
    circle = @discs[0][src].shift(1)[0]
    @discs[0][dst].unshift(circle)
    @cnt += 1
    if @cnt >= @loop
      display(@discs)
      exit()
    end
    hanoi(n-1, tmp, src, dst) # n-1個の石板をtmpからdstへ移動
  end
end

def display(discs)
  puts discs[0]["Left"].size == 0 ? "-" : discs[0]["Left"].reverse.join(" ")
  puts discs[0]["Center"].size == 0 ? "-" : discs[0]["Center"].reverse.join(" ")
  puts discs[0]["Right"].size == 0 ? "-" : discs[0]["Right"].reverse.join(" ")
end

h = read_header
MAX_X = h[0].to_i
MAX_Y = h[1].to_i
x = 0
y = 0
cnt = 0
beam = 0

while s = gets
    p s.chomp.split("")
end
exit()
(1..disc).each { |v| ary_init << v }
@discs = ["Left" => ary_init, "Center" =>[], "Right" => []]
hanoi(cnt, "Left", "Center", "Right")
display(@discs)
