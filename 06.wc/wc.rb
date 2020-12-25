# frozen_string_literal: true

require 'optparse'
path = ARGV
options = ARGV.getopts('l')

def main(path, options = '')
  items = ruby_wc(path, options)
  generate_view_format_wc(items)
end

def ruby_wc(path, options = '')
  total_files = []
  files = []
  str = ''
  total_line = 0
  total_word_count = 0
  total_byte_size = 0
  file_argf = ARGF.class.new(*path)
  file_argf.each_line do |line|
    str += line
    next unless file_argf.eof?

    make_array_files(total_files, files, str, file_argf, options)
    total_line += str.lines.count
    if options['l'] == false
      total_word_count += str.split(/\s+/).size
      total_byte_size += str.bytesize
    end
    files = []
    str = ''
  end
  total_files(total_files, total_line, total_word_count, total_byte_size, options)
end

def total_files(total_files, total_line, total_word_count, total_byte_size, options)
  total_files_data = if options['l']
                       [total_line, 'total']
                     else
                       [total_line, total_word_count.to_s.rjust(6), total_byte_size.to_s.rjust(6), 'total']
                     end
  total_files << total_files_data if total_files.size > 1
  total_files
end

def make_array_files(total_files, files, str, file_argf, options)
  files << str.lines.count
  if options['l'] == false
    files << str.split(/\s+/).size.to_s.rjust(6)
    files << str.bytesize.to_s.rjust(6)
  end
  files << file_argf.filename if file_argf.filename != '-'
  total_files << files
end

def generate_view_format_wc(items)
  formatted_item = ''
  items.each do |item|
    formatted_item += item.join(' ')
    formatted_item += "\n"
  end
  formatted_item
end

print main(path, options) if __FILE__ == $PROGRAM_NAME

