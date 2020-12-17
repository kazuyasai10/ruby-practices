# frozen_string_literal: true

score_str = ARGV[0]

def main(score_str)
  total_frames = make_frame_array_from_score(score_str)
  bowling_score = calc_score(total_frames)
  puts bowling_score
  bowling_score
end

def strike?(frames)
  frames.first == 10
end

def spare?(frames)
  frames.length == 2 && frames.sum == 10
end

def make_frame_array_from_score(score_str)
  total_frames = []
  frames = []
  scores = score_str.chars.map { |s| s == 'X' ? 10 : s.to_i }
  scores.each do |score|
    frames << score
    if total_frames.length > 9
      total_frames[9].push(*frames)
      frames = []
    elsif strike?(frames) || frames.length == 2
      total_frames << frames
      frames = []
    end
  end
  total_frames
end

def calc_strike(total_frames, frames, index)
  if index == 8 # 通常のストライクで計算すると９フレーム目のみtotal_frames[index + 2][0]がnilになってしまうため、calc_strike_last関数を使用する。
    calc_strike_last(total_frames, frames, index)
  elsif index == 9
    frames.sum
  elsif strike?(frames) && total_frames[index + 1][0] == 10 && total_frames[index + 2][0] == 10
    30
  elsif strike?(frames) && total_frames[index + 1][0] == 10
    20 + total_frames[index + 2][0]
  else
    10 + total_frames[index + 1][0] + total_frames[index + 1][1]
  end
end

def calc_strike_last(total_frames, frames, index)
  if strike?(frames) && total_frames[index + 1][0] == 10 && total_frames[index + 1][1] == 10
    30
  elsif strike?(frames) && total_frames[index + 1][0] == 10
    20 + total_frames[index + 1][1]
  else
    10 + total_frames[index + 1][0] + total_frames[index + 1][1]
  end
end

def calc_spare(total_frames, index)
  10 + total_frames[index + 1][0]
end

def calc_score(total_frames)
  point = 0
  total_frames.each_with_index do |frames, index|
    point += if strike?(frames)
               calc_strike(total_frames, frames, index)
             elsif spare?(frames)
               calc_spare(total_frames, index)
             else
               frames.sum
             end
  end
  point
end

main(score_str) if __FILE__ == 'bowling.rb'
