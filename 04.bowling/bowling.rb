# frozen_string_literal: true

score_str = ARGV[0]

def main(score_str)
  total_frames = make_frame_array_from_score(score_str)
  calc_score(total_frames)
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

def calc_score(total_frames)
  point = total_frames.sum([]).sum # 数字を単純に合計する。次の繰り返しでストライク、スペアのボーナスを加算する
  total_frames.first(9).each_with_index do |frames, index| # 合算のみの最後のフレームは対象外
    next_frame = total_frames[index + 1]
    second_next_frame = total_frames[index + 2]
    if strike?(frames)
      point += next_frame[0]
      point += next_frame[1] || second_next_frame[0]
    elsif spare?(frames)
      point += next_frame[0]
    end
  end
  point
end

puts main(score_str) if __FILE__ == $0
