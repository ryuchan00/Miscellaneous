# https://docs.ruby-lang.org/ja/latest/class/Forwardable.html#I_DEF_DELEGATOR
# def_delegator
# メソッドの移譲先を設定する

require 'forwardable'
class MyQueue
  extend Forwardable
  attr_reader :queue

  def initialize
    @queue = []
  end

  def_delegator :@queue, :push, :mypush

  def_delegators :@queue, :size, :<<, :map

  # これと同じ意味
  # def_delegator :@queue, :size
  # def_delegator :@queue, :<<
  # def_delegator :@queue, :map
end

q = MyQueue.new
# MyQueue#pushが呼ばれる
p q.mypush 42
# MyQueue#queueが呼ばれる
p q.queue # => [42]
# MyQueue#pushを呼ぶことを許可しない
# q.push 23  # => NoMethodError

# def_delegators
# メソッドの委譲先をまとめて設定します。
p q.size
p q << 99
p q.map { |n| n % 2 == 0 }
