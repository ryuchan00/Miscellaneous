# Gemのparallelを使用して、並列化を行う
require 'parallel'

def fib(n)
  n < 2 ? 1 : fib(n - 1) + fib(n - 2)
end

Parallel.each([38,38]) do |n|
  p fib(n)
end

result = Parallel.map([38,38]) do |n|
  fib(n)
end
p result