# frozen_string_literal: true

require 'optparse'
require 'etc'

# 行数、単語数、バイト数
#       1       3      37 text.txt
options = ARGV.getopts('alr')
path = ARGF || '.' # 引数がなければ"."で現在のディレクトリを返す

def main(path, options = '')
  items = ruby_wc(path, options)
end

def ruby_wc(_path, options = '')
  if options['l']
    p 'オプションlですよ'
    # wc_l(path)
  else
    p 'オプションなしですよ'
    str=make_file
    
  end
end

def make_file
    str= ''
  ARGF.each_line do |line|
  p ARGF.file.size
  ARGF.eof?
  end
str
 p count_line(str)
 p count_words(str)
 p str.bytesize
end

p ARGF.getbyte

def count_words(str)
    ary = str.split(/\s+/)
    ary.size
  end

def count_line(str)
    str.lines.count
end


print main(path, options) if __FILE__ == $PROGRAM_NAME
