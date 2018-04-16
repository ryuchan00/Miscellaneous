# Processはメモリの変更を共有しない(おそらく専用領域をアロケートされている。めっちゃメモリ容量食いそう)
str = "Hello, world!"

Process.fork do
  str.upcase!
  p str # => "HELLO, WORLD!"
end
Process.waitall
p str # => "Hello, world!"