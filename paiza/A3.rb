# coding: utf-8

# 紙を上記のように折る回数Nが与えられるので
# 紙を折って広げたあとの山折り谷折りの折り目を計算する
# プログラムを作成してください。
# http://paiza.hatenablog.com/entry/2016/02/15/ITエンジニアを目指す学生が、就活を有利に進める
# 備考： 標準入力で紙を折る回数Nを取得し、谷折りを 0 山折りを 1 として出力する

def new_line
  return "\n"
end

def read_header
  return gets.chomp
end

def read_data
  return gets.chomp.split(" ")
end

def sort(temp)
  ret = temp + "0" + temp
  num = temp.length + 1 + temp.length.div(2)
  ret.to_s[num] = "1"
  return ret
end

def recursive(n, temp="0")
  if n == 1
    return temp
  end
  return recursive(n - 1, sort(temp))
end

# 繰り返し回数
n = read_header.to_i
puts recursive(n)
exit(0)
