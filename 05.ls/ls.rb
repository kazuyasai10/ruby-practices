# frozen_string_literal: true
require 'optparse'


options = ARGV.getopts('alr')
input = ARGV[0]

#puts input
#puts options

#ls-a
if options["a"] 
Dir.foreach('.').sort.each do |item|
  puts item
end

#ls
else
  Dir.foreach('.').sort.each do |item|
    next if item == '.' or item == '..'
    next if item.start_with?(".")
    puts item
  end
end

puts fs.mode
