require 'minitest/autorun'
require './bowling'

class BowlingScoreTest < Minitest::Test
  def test_print_score_case1
    assert_equal [[0, 10], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [6, 4, 5]], make_frame_array_from_score('0X90038273X9180X645')
  end

  def test_print_score_case2
    assert_equal [[0, 10], [1, 5], [0, 0], [0, 0], [10], [10], [10], [5, 1], [8, 1], [0, 4]], make_frame_array_from_score('0X150000XXX518104')
  end

  def test_print_score_case_final_Strike
    assert_equal [[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [10,10,10]], make_frame_array_from_score('6390038273X9180XXXX')
  end

  # def test_calc_score_fainal
  #   assert_equal 139, calc_score([[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [6, 4, 5]])
  # end

  # def test_calc_score
  #   assert_equal 107, calc_score([[0, 10], [1, 5], [0, 0], [0, 0], [10], [10], [10], [5, 1], [8, 1], [0, 4]])
  # end

  def test_calc_score_last
    assert_equal 164, calc_score([[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [10,10,10]])
  end

  # def test_calc_score_mini_spare
  #   assert_equal 25, calc_score([[6, 4], [5, 5]])
  # end

  # def test_calc_score_mini_strike
  #   assert_equal 30, calc_score([[10], [10]])
  # end

  # def test_calc_score_mini
  #   assert_equal 94, calc_score([[0, 10], [1, 5], [0, 0],[0, 0], [10], [10], [10], [5, 1]])
  # end

end
