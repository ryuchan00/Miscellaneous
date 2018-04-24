# Process.forkを使用して並列化した例

def fib(n)
  n < 2 ? 1 : fib(n - 1) + fib(n - 2)
end

t1 = Thread.new { puts fib(38) }
t2 = Thread.new { puts fib(38) }

t1.join; t2.join

# $ time ruby ruby_verification/Thread/fib_threaded.rb
# 63245986
# 63245986
# ruby ruby_verification/Thread/fib_threaded.rb  18.84s user 0.28s system 98% cpu 19.423 total
