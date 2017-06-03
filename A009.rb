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

h = read_header
max_y = h[0].to_i
max_x = h[1].to_i
x = 0
y = 0
cnt = 0
beam = 0

box = Array.new
while s = gets
    box.push(s.chomp.split(""))
end

# 箱の外に出たら終了
# beamの方向は0:左 1:右 2:上 3:下
# 探索中に"\\"または"/"があった場合、方向転換する。
while (0 <= x && x < max_x && 0 <= y && y < max_y)
  case box[y][x]
  when "\\" then
    case beam
    when 0 then
      beam = 3
    when 1 then
      beam = 2
    when 2 then
      beam = 1
    when 3 then
      beam = 0
    end
  when "/" then
    case beam
    when 0 then
      beam = 2
    when 1 then
      beam = 3
    when 2 then
      beam = 0
    when 3 then
      beam = 1
    end
  end
  # 現在の方向へ1マス移動
  case beam
  when 0 then
    x += 1
  when 1 then
    x -= 1
  when 2 then
    y -= 1
  when 3 then
    y += 1
  end
  cnt += 1
end

puts cnt
