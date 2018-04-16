# Rubyの並列処理には限界があり、CPUバウンド(CPUにかかる負荷が中心となること)なRubyのプログラムは、
# threadで並列に実行化してもパフォーマンスが改善しない

def fib(n)
  n < 2 ? 1 :fib(n - 1) + fib(n - 2)
end

puts fib(38)
puts fib(38)

# $ time ruby ruby_verification/Thread/fib.rb
# 63245986
# 63245986
# ruby ruby_verification/Thread/fib.rb  18.68s user 0.41s system 98% cpu 19.465 total
