# frozen_string_literal: true

require 'optparse'

options = ARGV.getopts('alr')
path = ARGV[0] || '.' # 引数がなければ"."で現在のディレクトリを返す

def main(path, options = '')
  ruby_ls(path, options)
end

# ls-a
def ruby_ls(path, options = '')
  items = []
  if options['a']
    Dir.foreach(path).sort.each do |item|
      items << item
    end

  # ls
  else
    Dir.foreach(path).sort.each do |item|
      next if (item == '.') || (item == '..')
      next if item.start_with?('.')

      items << item
    end
  end
  items
end

puts main(path, options) if __FILE__ == $PROGRAM_NAME
