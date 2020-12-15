# frozen_string_literal: true

def main
  score = ARGV[0]
  frames = make_frame_array_from_score(score)
  puts calc_score(frames)
end

def strike?(frame)
  frame.first == 10
end

def spare?(frame)
  frame.length == 2 && frame.sum == 10
end

def last_frame?(frames, _frame)
  frames[9] != NIL && frames[9][0] == 10 && frames[9][1] == 10 || frames[9] != NIL && frames[9].sum == 10
end

def make_frame_array_from_score(score)
  frames = []
  frame = []
  score.chars.each do |s|
    frame << (s == 'X' ? 10 : s.to_i)
    if last_frame?(frames, frame)
      frames[9] << frame[0]
    elsif strike?(frame) || frame.length == 2 #  ストライクまたは10本倒れたときス次の配列へ
      frames << frame
      frame = [] # 次のフレームを定義
    end
  end
  frames
end

def calc_turkey(frames, frame, index)
  point = 0
  point += if strike?(frame) && frames[index + 1][0] == 10 && frames[index + 2][0] == 10 # 3回連続ストライク
             30
           elsif strike?(frame) && frames[index + 1][0] == 10 # 2回連続ストライク
             20 + frames[index + 2][0]
           else
             10 + frames[index + 1].first + frames[index + 1][1].to_i
           end
  point
end

def calc_turkey_last(frames, frame, index)
  point = 0
  if point += if strike?(frame) && frames[index + 1][0] == 10 && frames[index + 1][1] == 10 # 3回連続ストライク
                30
              elsif frame[0] == 10 && frames[index + 1][0] == 10 # 2回連続ストライク
                20 + frames[index + 1][0]
              else
                10 + frames[index + 1].first + frames[index + 1][1].to_i
              end
    point
  end
end

def calc_spare(frames, index)
  point = 0
  point + 10 + frames[index + 1].first
end

def calc_1_8_frame(frame, frames, index)
  point = 0
  point +
    if frames.last == frame
      point + frame.sum

    elsif strike?(frame)
      calc_turkey(frames, frame, index)

    elsif spare?(frame) # スペアの場合
      calc_spare(frames, index)
    else
      frame.sum
    end
end

def calc_score(frames)
  point = 0
  frames.each_with_index do |frame, index|
    if frames[8] != frame
      point += calc_1_8_frame(frame, frames, index)
    elsif strike?(frame)
      point += calc_turkey_last(frames, frame, index)
    elsif  spare?(frame)
      calc_spare(frames, index)
    else
      point += frame.sum

    end
  end
  point
end

main if __FILE__ == $0
