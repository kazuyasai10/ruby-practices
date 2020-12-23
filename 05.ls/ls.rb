# frozen_string_literal: true

require 'optparse'
require 'etc'

options = ARGV.getopts('alr')
path = ARGV[0] || '.' # 引数がなければ"."で現在のディレクトリを返す

def main(path, options = '')
  items = ruby_ls(path, options)
  options['l'] == true ? generate_view_format_ls_l(items, path) : generate_view_format_ls(items)
end

def ruby_ls(path, options = '')
  if options['l'] && options['r'] && options['a']
    ls_la(path).reverse
  elsif options['l'] && options['r']
    ls_l(path).reverse
  elsif options['a'] && options['r']
    ls_a(path).reverse
  elsif options['l'] && options['a']
    ls_la(path)
  elsif options['a']
    ls_a(path)
  elsif options['l']
    ls_l(path)
  elsif options['r']
    ls(path).reverse
  else
    ls(path)
  end
end

def make_symbol_mode(item, path)
  item_path = File.absolute_path(item, path)
  fs = File::Stat.new(item_path)
  file_type = fs.ftype
  mode = fs.mode.to_s(8)
  other = mode[-1]
  group = mode[-2]
  owner = mode[-3]
  file_type_hash(file_type) + mode_hash(owner) + mode_hash(group) + mode_hash(other)
end

# もともとmake_symbol_modeに含まれていたがrobocopにtoo manyと言われたので切り出し。
def file_type_hash(filetype)
  {
    'fifo' => 'p',
    'characterSpecial' => 'c',
    'directory' => 'd',
    'blockSpecial' => 'b',
    'file' => '-',
    'link' => 'l',
    'socket' => 's'
  }[filetype]
end

def mode_hash(integer)
  {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }[integer]
end

def calc_ls_total(path)
  blocks = 0
  Dir.foreach(path).sort.each do |item|
    item_path = File.expand_path(item, path)
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

def ls_a(path)
  items = []
  Dir.foreach(path).sort.each do |item|
    items << item
  end
end

def ls_l(path)
  items = []
  Dir.foreach(path).sort.each do |item|
    next if (item == '.') || (item == '..')
    next if item.start_with?('.')

    item_path = File.absolute_path(item, path)
    fs = File::Stat.new(item_path)
    size = fs.size.to_s.rjust(6)
    atime = fs.atime.strftime('%_m %_d %R')
    hard_link = fs.nlink.to_s.rjust(3)
    user = Etc.getpwuid(File.stat(item_path).uid).name
    group_name = Etc.getgrgid(File.stat(item_path).gid).name
    mode_symbol = make_symbol_mode(item, path)
    items << [mode_symbol, hard_link, user, group_name, size, atime, item]
  end
  items
end

def ls_la(path)
  items = []
  Dir.foreach(path).sort.each do |item|
    item_path = File.absolute_path(item, path)
    fs = File::Stat.new(item_path)
    size = fs.size.to_s.rjust(6)
    atime = fs.atime.strftime('%_m %_d %R')
    hard_link = fs.nlink.to_s.rjust(3)
    user = Etc.getpwuid(File.stat(item_path).uid).name
    group_name = Etc.getgrgid(File.stat(item_path).gid).name
    mode_symbol = make_symbol_mode(item, path)
    items << [mode_symbol, hard_link, user, group_name, size, atime, item]
  end
  items
end

# viewをオプション-lを用いる場合とそれ以外と２パターン用意した。
def generate_view_format_ls(items)
  item_max_length = items.max_by(&:length).length + 2
  formatted_item = ''
  items.each.with_index(1) do |item, index|
    formatted_item += item.ljust(item_max_length)
    formatted_item += "\n" if (index % 3).zero?
    formatted_item += "\n" if items.length == index && !(index % 3).zero? # 最後が３の倍数だったら改行を入れない。
  end
  formatted_item
end

def generate_view_format_ls_l(items, path)
  formatted_item = "total  #{calc_ls_total(path)}\n"
  items.each do |item|
    formatted_item += item.join(' ')
    formatted_item += "\n"
  end
  formatted_item
end

print main(path, options) if __FILE__ == $PROGRAM_NAME

