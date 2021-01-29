# frozen_string_literal: true

require 'minitest/autorun'
require './wc'

class WcTest < Minitest::Test
  def test_wc
    expected = <<~TEXT
      1      1     46 ./test_wc/aaa.readme
      3      3     25 ./test_wc/text.txt
      4      4     71 total
    TEXT
    assert_equal expected, main(['./test_wc/aaa.readme', './test_wc/text.txt'], { 'a' => false, 'l' => false, 'r' => false })
  end

  def test_wc_l
    expected = <<~TEXT
      1 ./test_wc/aaa.readme
      3 ./test_wc/text.txt
      4 total
    TEXT
    assert_equal expected, main(['./test_wc/aaa.readme', './test_wc/text.txt'], { 'a' => false, 'l' => true, 'r' => false })
  end

  def test_wc_1file
    expected = <<~TEXT
      1      1     46 ./test_wc/aaa.readme
    TEXT
    assert_equal expected, main(['./test_wc/aaa.readme'], { 'a' => false, 'l' => false, 'r' => false })
  end
end

