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
  total_frames.each_with_index do |frames, index|
    next unless index != 9

    if strike?(frames)
      point += total_frames[index + 1][0]
      point += total_frames[index + 1][1] || total_frames[index + 2][0]
    end
    point += total_frames[index + 1][0] if spare?(frames)
  end
  point
end

puts main(score_str) if __FILE__ == $PROGRAM_NAME
