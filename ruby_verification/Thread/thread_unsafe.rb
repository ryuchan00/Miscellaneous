c = 0
t1 = Thread.new { 1000.times { c += 1 } }
t2 = Thread.new { 1000.times { c += 1 } }
t1.join; t2.join
p c

# $ ruby ruby_verification/Thread/thread_unsafe.rb
# 2000

# $ jruby ruby_verification/Thread/thread_unsafe.rb
# 1522
