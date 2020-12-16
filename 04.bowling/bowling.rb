# frozen_string_literal: true

score = ARGV[0]

def main(score)
  total_frames = make_frame_array_from_score(score)
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

def last_frame?(total_frames)
  !total_frames[9].nil? && total_frames[9][0] == 10 && total_frames[9][1] == 10 || !total_frames[9].nil? && total_frames[9].sum == 10
end

def make_frame_array_from_score(score)
  total_frames = []
  frames = []
  score.chars.each do |s|
    frames << (s == 'X' ? 10 : s.to_i)
    if last_frame?(total_frames)
      total_frames[9] << frames[0]
    elsif strike?(frames) || frames.length == 2
      total_frames << frames
      frames = [] # 次のフレームを定義
    end
  end
  total_frames
end

def calc_strike(total_frames, frames, index)
  if strike?(frames) && total_frames[index + 1][0] == 10 && total_frames[index + 2][0] == 10
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
  10 + total_frames[index + 1].first
end

def calc_1_8_frame(total_frames, frames, index)
  point = 0
  point +
    if total_frames.last == frames
      point + frames.sum

    elsif strike?(frames)
      calc_strike(total_frames, frames, index)

    elsif spare?(frames)
      calc_spare(total_frames, index)
    else
      frames.sum
    end
end

def calc_score(total_frames)
  point = 0
  total_frames.each_with_index do |frames, index|
    if total_frames[8] != frames
      point += calc_1_8_frame(total_frames, frames, index)
    elsif strike?(frames)
      point += calc_strike_last(total_frames, frames, index)
    elsif  spare?(frames)
      calc_spare(total_frames, index)
    else
      point += frames.sum
    end
  end
  point
end

main(score) if __FILE__ == $0
