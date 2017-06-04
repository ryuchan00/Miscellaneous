# coding: utf-8

def read_header
  return gets.chomp.split(" ").map(&:to_i)
end

def split_data(d)
  return d.chomp.split(" ").map(&:to_i)
end

H, W, N = read_header
# filed生成
filed = Array.new(H).map{ Array.new(W, ".") } 

while d = gets
  start_y = 0
  # 読み込み
  h_i ,w_i ,x_i = split_data(d)
  
  # y軸は上から参照する(下から参照すると抜け漏れが発生するため)
  0.upto(H - 1) do |y|
    cnt = 0
    
    x_i.upto(x_i + w_i - 1) do |x|
      if filed[y][x] == "." then
        cnt += 1
      else
        cnt = 0
        break
      end
    end
    
    # '#'が出現する行を探索したか、yが底辺まで到達した場合、'#'埋め処理に入る
    if cnt != w_i || y + 1 == H
      if cnt != w_i then
        start_y = y - 1
      else
        start_y = y
      end
      break
    end
  end
  
  # '#'埋め処理
  start_y.downto(start_y - h_i + 1) do |yy|
        x_i.upto(x_i + w_i - 1) do |x|
          filed[yy][x] = "#"
        end
      end
end

filed.each { |f| puts f.join("")}
