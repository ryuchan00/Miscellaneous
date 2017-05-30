def new_line
  return "\n"
end

def read
  return gets.chomp.split(" ")
  # return gets
end

h = read
seats = Array.new(h[0].to_i, false)
while s = gets
  d = s.chomp.split(" ")
  point = d[1].to_i - 1
  count = 0
  d[0].to_i.times {
    if seats[point] == false then
      if point + 1 == h[0].to_i
        point = 0
      else
        point += 1
      end
      count += 1
    else
      break
    end
  }
  if count == d[0].to_i
    point = d[1].to_i - 1
    d[0].to_i.times {
      seats[point] = true
      if point + 1 == h[0].to_i
        point = 0
      else
        point += 1
      end
    }
  end
end
puts seats.count(true)
