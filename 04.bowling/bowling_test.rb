# frozen_string_literal: true

require 'minitest/autorun'
require './bowling'

class BowlingScoreTest < Minitest::Test
  def test_score
    assert_equal 107, main('0X150000XXX518104')
  end

  def test_score_last_frames_spare
    assert_equal 139, main('6390038273X9180X645')
  end

  def test_score_last_3strike
    assert_equal 164, main('6390038273X9180XXXX')
  end

  def test_score_last_frames_1strike
    assert_equal 134, main('6390038273X9180XX00')
  end

  def test_score_perfect_game
    assert_equal 300, main('XXXXXXXXXXXX')
  end

  def test_score_X10
    assert_equal 143, main('6390038273X9180XX25')
  end

end
