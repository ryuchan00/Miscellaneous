require 'optparse'

opt = OptionParser.new
opt.on('-a', '--add', 'add an item') { puts 'Added' }
opt.on('-d', '--del', 'delete an item') { puts 'Deleted' }
opt.parse(ARGV)