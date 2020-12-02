require 'minitest/autorun'
require './bowling'

class BowlingScoreTest < Minitest::Test
  def test_calculate_score
    assert_equal 1, calculate_score(1)
  end

  def test_chars_score_to_integer
    assert_equal [1, 2], chars_score_to_i('12')
  end

  def test_delimiter_score
    assert_equal [[1, 2], [3, 4]], delimiter_score_for_each_frame([1, 2, 3, 4])
  end

  def test_sum_score
    assert_equal 10, sum_score([[1, 2], [3, 4]])
  end

  def test_sum_score_strike
    assert_equal 18, sum_score([[10, 0], [6, 2]])
    assert_equal 30, sum_score([[10, 0], [10, 10]])
  end

  def test_sum_score_spare
    assert_equal 15, sum_score([[6, 4], [5, 0]])
    assert_equal 20, sum_score([[6, 4], [10, 0]])
  end

end
