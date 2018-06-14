def foo
  p :a
  return
  raise StandardError, 'normal error'
rescue => e
  p :rescue
ensure
  p :ensure
end

foo
