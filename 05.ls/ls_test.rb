# frozen_string_literal: true

require 'minitest/autorun'
require './ls'

class LsTest < Minitest::Test
  def test_ls
    expected = <<~TEXT
    directory  foo.txt    readme     
    test.txt 
    TEXT
    assert_equal expected, main('./ls_test')
  end

  # def test_ls_a
  #   expected = '. .. .kakushi test.txt'
  #   assert_equal expected, main('./ls_test', { 'a' => true, 'l' => false, 'r' => false })
  # end
end
