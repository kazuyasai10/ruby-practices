# frozen_string_literal: true

require 'optparse'
require 'etc'

options = ARGV.getopts('alr')
path = ARGV[0] || '.' # 引数がなければ"."で現在のディレクトリを返す

def main(path, options = '')
  items = ruby_ls(path, options)
  if options['l']
    puts "total  #{calc_ls_total(path)}"
    items.each do |item|
      puts item.join('  ')
    end
  else
    print gnerate_print_item_str(items)
    gnerate_print_item_str(items)
  end
end

# ls-a
def ruby_ls(path, options = '')
  items = []
  if options['l'] && options['r']
    # p 'lr反応しています'
  elsif options['a']
    Dir.foreach(path).sort.each do |item|
      items << item
    end
    # ls -l
  elsif options['l']
    Dir.foreach(path).sort.each do |item|
      item_path = File.absolute_path(item)
      fs = File::Stat.new(item_path)
      size = fs.size
      atime = fs.atime.strftime('%_m %_d %R')
      hard_link = fs.nlink
      user = Etc.getpwuid(File.stat(item_path).uid).name
      group_name = Etc.getgrgid(File.stat(item_path).gid).name
      mode_symbol = make_symbol_mode(item)
      items << [mode_symbol, hard_link.to_s, user, group_name, size.to_s, atime, item]
    end

    # ls
  else
    items = ls(path)
  end
  items
end

def get_count_max_filename(items)
  item_length = []
  items.each do |item|
    item_length << item.length
  end
  item_length.max
end

def gnerate_print_item_str(items)
  item_max_length = get_count_max_filename(items) + 2
  formatted_item = ''
  items.each.with_index(1) do |item, index|
    formatted_item += item.ljust(item_max_length)
    formatted_item += "\n" if (index % 3).zero?
    formatted_item += "\n" if items.length == index && !(index % 3).zero? # 最後が３の倍数だったら改行を入れない。
  end
  formatted_item
end

def make_symbol_mode(item)
  item_path = File.absolute_path(item)
  fs = File::Stat.new(item_path)
  file_type = fs.ftype
  mode = fs.mode.to_s(8)
  other = mode[-1]
  group = mode[-2]
  owner = mode[-3]

  file_type_hash = {
    'fifo' => 'p',
    'characterSpecial' => 'c',
    'directory' => 'd',
    'blockSpecial' => 'b',
    'file' => '-',
    'link' => 'l',
    'socket' => 's'
  }

  mode_hash = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }
  file_type_hash[file_type] + mode_hash[owner] + mode_hash[group] + mode_hash[other]
end

def calc_ls_total(path)
  blocks = 0
  Dir.foreach(path).sort.each do |item|
    item_path = File.absolute_path(item)
    fs = File::Stat.new(item_path)
    blocks += fs.blocks
  end
  blocks
end

def ls(path)
  items = []
  Dir.foreach(path).sort.each do |item|
    next if (item == '.') || (item == '..')
    next if item.start_with?('.')

    items << item
  end
  items
end

main(path, options) if __FILE__ == $PROGRAM_NAME
