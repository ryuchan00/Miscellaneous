require 'active_model'
require 'active_support'

module SampleHooks
  extend ActiveSupport::Concern

  included do
    method = :foo

    orig = "#{method}_without_hook".to_sym

    alias_method orig, method

    define_method(method) do |*args, &block|
      run_callbacks(method) do
        send(orig, *args, &block)
      end
    end
  end
end

class SampleCallbackKlass
  def after_foo(record)
    puts "after_foo"
  end
end

class SampleKlass
  def foo
    puts "foo"
  end

  extend ActiveModel::Callbacks

  # fooメソッドの定義後じゃないとダメ
  include SampleHooks

  define_callbacks :foo, scope: %i[kind name]
  set_callback :foo, :after, SampleCallbackKlass.new
end

s = SampleKlass.new
s.foo
