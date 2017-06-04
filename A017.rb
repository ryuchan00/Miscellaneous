# coding: utf-8

def read_header
  return gets.chomp.split(" ").map(&:to_i)
end

def split_data(d)
  return d.chomp.split(" ").map(&:to_i)
end

H, W, N = read_header
# generate filed
filed = Array.new(H).map{ Array.new(W, ".") } 

while d = gets
  # 読み込み
  h_i ,w_i ,x_i = split_data(d)
  
  # y軸は上から参照する
  0.upto(H - 1) do |y|
    cnt = 0
    
    x_i.upto(x_i + w_i - 1) do |x|
    # p "x " + x.to_s
    # p "y " + y.to_s
      if filed[y][x] == "." then
        cnt += 1
      else
        cnt = 0
        break
      end
    end
    
    # '#'埋め処理
    if cnt != w_i || y + 1 == H
      if cnt != w_i
        y -= 1
      end
      y.downto(y - h_i + 1) do |yy|
        x_i.upto(x_i + w_i - 1) do |x|
          # p "insert"
          # p "x " + x.to_s
          # p "y " + y.to_s
          filed[yy][x] = "#"
          # filed.each { |f| puts f.join("")}
        end
      end
      # p "insert break"
      break
    end
  end
  # p "big loop break"
end
filed.each { |f| puts f.join("")}
exit()

