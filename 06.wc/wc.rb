# frozen_string_literal: true

require 'optparse'

options = ARGV.getopts('l')

def main(options = '')
  items = ruby_wc(options)
  generate_view_format_wc(items)
end

def ruby_wc(options = '')
  total_files = []
  files = []
  str = ''
  total_line = 0
  total_word_count = 0
  total_byte_size = 0
  ARGF.each_line do |line|
    str += line
    next unless ARGF.eof?

    files << str.lines.count.to_s.rjust(6)
    total_line += str.lines.count
    if options['l']
      files << ARGF.filename if ARGF.filename != '-'
      total_files << files
      files = []
      str = ''
    else
      ary = str.split(/\s+/)
      files << ary.size.to_s.rjust(6)
      total_word_count += ary.size
      files << str.bytesize.to_s.rjust(6)
      total_byte_size += str.bytesize
      files << ARGF.filename if ARGF.filename != '-'
      total_files << files
      files = []
    end
    str = ''
  end
  total_files_data = if options['l']
                       [total_line.to_s.rjust(6), 'total']
                     else
                       [total_line.to_s.rjust(6), total_word_count.to_s.rjust(6), total_byte_size.to_s.rjust(6), 'total']
                     end
  total_files << total_files_data if total_files.size > 1
  total_files
end

def generate_view_format_wc(items)
  formatted_item = ''
  items.each do |item|
    formatted_item += item.join(' ')
    formatted_item += "\n"
  end
  formatted_item
end

print main(options) if __FILE__ == $PROGRAM_NAME
