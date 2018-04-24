a = []
t1 = Thread.new { 1000.times { a.concat([1, 2, 3]) } }
t2 = Thread.new { 1000.times { a.concat([1, 2, 3]) } }
t1.join; t2.join
p a

# jRubyだと並列処理のため失敗する
# $ jruby ruby_verification/Thread/thread_unsafe_array.rb
# ConcurrencyError: Detected invalid array contents due to unsynchronized modifications with concurrent users
# concat at org/jruby/RubyArray.java:1580
# block in ruby_verification/Thread/thread_unsafe_array.rb at ruby_verification/Thread/thread_unsafe_array.rb:2
# times at org/jruby/RubyFixnum.java:299
# block in ruby_verification/Thread/thread_unsafe_array.rb at ruby_verification/Thread/thread_unsafe_array.rb:2
