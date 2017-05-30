input_lines = gets
# p gets.to_i
# p input_lines
words = Hash.new
# input_lines.times {
  # s = gets.chomp.split(",")
  # s = gets.chomp.split(" ")
  s = input_lines.split(" ")
  # print "hello = ", s[0], " , world = ", s[1], "\n"
  s.each do |word|
    # p word
    if words.has_key?(word.to_s)
      words[word.to_s] += 1
    else
      words[word.to_s] = 1
    end
  end
# }
words.each { |k, v|
  puts k.to_s + " " + v.to_s
}
