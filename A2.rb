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
#バケット作成
bucket = Array.new(n, false)
#'map(&:to_i)'は配列の要素全てをint型に変換する。
# books = read_data.map(&:to_i)
books = read_data.map{|item| item.to_i - 1}

for i in 0..n - 1 do
  bucket[books[i]] = i
end
ans = 0
for i in 0..n - 1 do
  if books[i] != i
    tmp = bucket[i]
    bucket[i], bucket[books[i]] = bucket[books[i]], bucket[i]
    books[i], books[tmp] = books[tmp], books[i]
    ans += 1
  end
end

puts ans
exit(0)
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
  p books.min_by { |num| books[i] > num.abs }
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
