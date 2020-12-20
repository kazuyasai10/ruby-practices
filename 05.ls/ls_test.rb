# frozen_string_literal: true

require 'minitest/autorun'
require './ls'

class BowlingScoreTest < Minitest::Test
  def test_ls
    assert_equal ['test.txt'], main('./ls_test')
  end

  def test_ls_a
    assert_equal ['.', '..', '.kakushi', 'test.txt'], main('./ls_test', { 'a' => true, 'l' => false, 'r' => false })
  end
end
