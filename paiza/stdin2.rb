input_lines = gets.to_i
input_lines.times {
      s = gets.chomp.split(",")
      print "hello = ", s[0], " , world = ", s[1], "\n"
}