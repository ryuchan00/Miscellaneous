# coding: utf-8

def new_line
  return "\n"
end

def read_header
  return gets.chomp.split(" ").map(&:to_i)
end

def split_data(d)
  return d.chomp.split(" ").map(&:to_i)
end

TEST = ''

H, W, N = read_header
# generate filed
filed = Array.new(H).map{ Array.new(W, ".") } 

while d = gets
  h_i ,w_i ,x_i = split_data(d)
  # 処理
  # for y in (H - 1)..0 do
  0.upto(H - 1) do |y|
    cnt = 0
    for x in x_i..(x_i + w_i - 1) do
    # p "x " + x.to_s
    # p "y " + y.to_s
      if filed[y][x] == "." then
        cnt += 1
      else
        cnt = 0
        break
      end
      # if cnt != w_i
      #   p "break"
      #   y -= 1
      #   break
      # end
    end
    # 場所確定後の#埋め処理
    if cnt != w_i || y == H - 1
      if cnt != w_i
        y -= 1
      end
      h_i.times do |h_p|
        for x in x_i..(x_i + w_i - 1) do
          # p "insert"
          # p "x " + x.to_s
          # p "y " + y.to_s
          filed[y][x] = "#"
          # filed.each { |f| puts f.join("")}
        end
        y -= 1
      end
      # p "insert break"
      break
    end
  end
  # p "big loop break"
end
filed.each { |f| puts f.join("")}
exit()

