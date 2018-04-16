# 2つのHTTPリクエストを発行する
# 順不同でリクエストが発行される
require 'net/http'
require 'uri'

t1= Thread.new do
  uri = URI.parse("http://gihyo.jp/magazine/wdpress")
  Net::HTTP.get_print(uri)
end

t2= Thread.new do
  uri = URI.parse("http://gihyo.jp/magazine/SD")
  Net::HTTP.get_print(uri)
end

t1.join; t2.join
