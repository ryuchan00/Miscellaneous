require 'concurrent'

a = Concurrent::Array.new
t1 = Thread.new { 1000.times { a.concat([1, 2, 3]) } }
t2 = Thread.new { 1000.times { a.concat([1, 2, 3]) } }
t1.join; t2.join
