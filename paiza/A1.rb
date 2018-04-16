def new_line
  return "\n"
end

def read_header
  return gets
end

def read_data
  return gets.chomp.split(" ")
end

# 繰り返し回数
n = read_header.to_i
i = 0
sort_count = 0
#'map(&:to_i)'は配列の要素全てをint型に変換する。
books = read_data.map(&:to_i)
n.times {
  j = i + 1

  #探索範囲
  loop_count = n - j

  min = books[i]
  min_key = i
  #最小値を探す
  loop_count.times {
    if books[j] < min
      # p "min"
      # puts min.class
      # p min
      # p "books[j]"
      # puts books[j].class
      # p books[j]
      min = books[j]
      min_key = j
    end
    j += 1
  }
  # puts "before"
  # p d
  if min_key != i
    books[min_key], books[i] = books[i], books[min_key]
    sort_count += 1
  end
  # puts "after"
  # p d
  i += 1
}
puts sort_count
exit(0)
