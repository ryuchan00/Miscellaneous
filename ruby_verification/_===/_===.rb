str = "hoge"

case str
when /hoge/
  p :hoge
when /fuga/
  p :fuga
else
  p :else
end

