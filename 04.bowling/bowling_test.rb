# frozen_string_literal: true

require 'minitest/autorun'
require './bowling'

class BowlingScoreTest < Minitest::Test
  def test_make_frame_array_from_score1
    assert_equal [[0, 10], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [6, 4, 5]], make_frame_array_from_score('0X90038273X9180X645')
  end

  def test_make_frame_array_from_score2
    assert_equal [[0, 10], [1, 5], [0, 0], [0, 0], [10], [10], [10], [5, 1], [8, 1], [0, 4]], make_frame_array_from_score('0X150000XXX518104')
  end

  def test_make_frame_array_from_score3
    assert_equal [[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [10, 10, 10]], make_frame_array_from_score('6390038273X9180XXXX')
  end

  def test_calc_score
    assert_equal 107, calc_score([[0, 10], [1, 5], [0, 0], [0, 0], [10], [10], [10], [5, 1], [8, 1], [0, 4]])
  end

  def test_calc_score_last_spare
    assert_equal 139, calc_score([[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [6, 4, 5]])
  end

  def test_calc_score_last_3strike
    assert_equal 164, calc_score([[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [10, 10, 10]])
  end

  def test_score
    assert_equal 107, main('0X150000XXX518104')
  end

  def test_score_2
    assert_equal 139, main('6390038273X9180X645')
  end

  def test_score_last_3strike
    assert_equal 164, main('6390038273X9180XXXX')
  end

  def test_score_3
    assert_equal 134, main('6390038273X9180XX00')
  end

end
