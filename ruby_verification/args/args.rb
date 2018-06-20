def args1(a, b = {}, c: c)
  p a
  p b
  p c
end

args1(1, [2, 3, 4], c: 5)
# args1(1, 2, 3, c: 5, 4) Error
