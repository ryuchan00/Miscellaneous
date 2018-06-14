require 'pry'
require './log_method'

Array.extend(LogMethod)
Array.log_method(:first)
[1, 2, 3].first
%w(a b c).first_without_logging
