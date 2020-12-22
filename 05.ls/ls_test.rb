# frozen_string_literal: true

require 'minitest/autorun'
require './ls'

class LsTest < Minitest::Test
  def test_ls
    expected = <<~TEXT
      directory  foo.txt    readme#{'     '}
      test.txt#{'   '}
    TEXT
    assert_equal expected, main('./ls_test')
  end

  def test_ls_a
    expected = <<~TEXT
      .          ..         .kakushi#{'   '}
      directory  foo.txt    readme#{'     '}
      test.txt#{'   '}
    TEXT
    assert_equal expected, main('./ls_test', { 'a' => true, 'l' => false, 'r' => false })
  end

  # def test_ls_l
  #   expected = <<~TEXT
  #   total 0
  #   drwxr-xr-x  2 kazuya.saito  staff  64 12 21 13:22 directory
  #   -rw-r--r--  1 kazuya.saito  staff   0 12 21 23:10 foo.txt
  #   -rw-r--r--  1 kazuya.saito  staff   0 12 21 23:09 readme
  #   -rw-r--r--  1 kazuya.saito  staff   0 12 20 23:39 test.txt
  #   TEXT
  #   assert_equal expected, main('./ls_test', { 'a' => false, 'l' => true, 'r' => false })
  # end
end
