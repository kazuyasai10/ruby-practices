# frozen_string_literal: true

score = ARGV[0]

TEN_POINTS = 10
FIRST_PITCH = 1
SECOND_PITCH = 2



def make_frame_array_from_score(score)
  frames = []
  frame = []
  scores = score.chars
  scores.each do |s|
    frame << if s == 'X'
               TEN_POINTS
             else
               s.to_i
             end
    if frames[9] != NIL && frames[9][0] == TEN_POINTS && frames[9][1] == TEN_POINTS || frames[9] != NIL && frames[9].sum == TEN_POINTS
      frames[9] << frame[0]
    elsif frame.length == FIRST_PITCH && frame.first == TEN_POINTS ||  frame.length == SECOND_PITCH # 1投目 && 10本倒れたときストライクの配列は次の行へ
      frames << frame # framesにframeを代入
      frame = [] # 次のフレームを定義
    end
  end
  frames
end

def s 
 
end

def calc_score(frames)
  point = 0
  frames.each_with_index do |frame, index|
    if frames.last != frame
      if frames[8] != frame

        if frame.first == TEN_POINTS
          point += if frame[0] == 10 && frames[index + 1][0] == 10 && frames[index + 2][0] == 10 # 3回連続ストライク
                     30
                   elsif frame[0] == 10 && frames[index + 1][0] == 10 # 2回連続ストライク
                     20 + frames[index + 2][0]
                   else
                     10 + frames[index + 1].first + frames[index + 1][1].to_i
                   end
        elsif frame.length == SECOND_PITCH && frame.sum == TEN_POINTS # スペアの場合
          point += 10
          break if frames[index + 1].nil?

          point += frames[index + 1].first
        else
          point += frame.sum
        end

      elsif frame.first == TEN_POINTS
        point += if frame[0] == 10 && frames[index + 1][0] == 10 && frames[index + 1][1] == 10 # 3回連続ストライク
                   30
                 elsif frame[0] == 10 && frames[index + 1][0] == 10 # 2回連続ストライク
                   20 + frames[index + 1][0]
                 else
                   10 + frames[index + 1].first + frames[index + 1][1].to_i
                 end
      elsif frame.length == SECOND_PITCH && frame.sum == TEN_POINTS # スペアの場合
        point += 10
        break if frames[index + 1].nil?

        point += frames[index + 1].first
      else
        point += frame.sum

      end

    else
      point += frame.sum
    end
  end
  point
end
