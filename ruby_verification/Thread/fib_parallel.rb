# Process.forkを使用して並列化した例

def fib(n)
  n < 2 ? 1 : fib(n - 1) + fib(n - 2)
end

Process.fork { puts fib(38) }
Process.fork { puts fib(38) }

Process.waitall

# $ time ruby ruby_verification/Thread/fib_parallel.rb
# 63245986
# 63245986
# ruby ruby_verification/Thread/fib_parallel.rb  11.75s user 0.26s system 179% cpu 6.693 total
