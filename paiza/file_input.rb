File.open("data.txt", "r") do |io|
  puts "---gets"
  p io.gets      #１行読み込んで表示

  puts "---readline"
  p io.readline  #１行読み込んで表示

  puts "---read"
  io.rewind      #読み込み位置を先頭に戻す
  p io.read(5)   #5バイト分読み込んで表示
  p io.read      #現在位置よりファイル全体を読み込んで表示

  puts "---readlines"
  io.rewind      #読み込み位置を先頭に戻す
  p io.readlines #ファイルの各行を要素とする配列を作成して表示
end
