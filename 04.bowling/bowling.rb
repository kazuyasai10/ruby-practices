score = ARGV[0]

def calculate_score(score)
  score
end

def chars_score_to_i(score)
  scores = score.chars
  shots = []
  scores.each do |score_string|
    if score_string == 'X'
      shots << 10
      shots << 0
    else
      shots << score_string.to_i
    end
  end
  shots
end

def delimiter_score_for_each_frame(shots)
  frames = []
  shots.each_slice(2) do |s|
    frames << s
  end
  frames
end

STRIKE = 10
SPARE = 10

def sum_score(frames)
  point = 0
  frames.each do |frame|
    if frame[0] == STRIKE # strike
        point += 10
        point += frame[1]
      elsif frame.sum == SPARE # spare
        point += frame[1][0] + 10
      else
        point += frame.sum
      end
  end
  point
end

p shots =  chars_score_to_i(score)
p frames = delimiter_score_for_each_frame(shots)
p sum_score(frames)