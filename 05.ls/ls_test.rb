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

  def test_ls_r
    expected = <<~TEXT
      test.txt   readme     foo.txt#{'    '}
      directory#{'  '}
    TEXT
    assert_equal expected, main('./ls_test', { 'a' => false, 'l' => false, 'r' => true })
  end

  def test_ls_l
    expected = <<~TEXT
      total  16
      drwxr-xr-x   2 kazuya.saito staff     64 12 22 13:47 directory
      -rw-r--r--   1 kazuya.saito staff      0 12 21 23:10 foo.txt
      -rw-r--r--   1 kazuya.saito staff      0 12 21 23:09 readme
      -rw-r--r--   1 kazuya.saito staff   4951 12 23 11:02 test.txt
    TEXT
    assert_equal expected, main('./ls_test', { 'a' => false, 'l' => true, 'r' => false })
  end

  def test_ls_lar
    expected = <<~TEXT
      total  16
      -rw-r--r--   1 kazuya.saito staff   4951 12 23 11:02 test.txt
      -rw-r--r--   1 kazuya.saito staff      0 12 21 23:09 readme
      -rw-r--r--   1 kazuya.saito staff      0 12 21 23:10 foo.txt
      drwxr-xr-x   2 kazuya.saito staff     64 12 22 13:47 directory
      -rw-r--r--   1 kazuya.saito staff      0 12 21 00:05 .kakushi
      drwxr-xr-x   6 kazuya.saito staff    192 12 20 23:39 ..
      drwxr-xr-x   7 kazuya.saito staff    224 12 22 13:47 .
    TEXT
    assert_equal expected, main('./ls_test', { 'a' => true, 'l' => true, 'r' => true })
  end
end
