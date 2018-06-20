def greet(name, *messages)
  p messages #[[{:a=>1, :b=>2}], [3, 4]]
  p messages[0] # [{:a=>1, :b=>2}]

end

greet('name', [a: 1, b: 2], [3, 4])
