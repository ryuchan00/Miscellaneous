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

# GVLの制約を逃れるて並列化にできるが、デメリットが2つある
# プロセスの起動が遅いこと
# メモリの共有を行わないこと(破壊的な変更をしても、各プロセス間で変更は共有されない)