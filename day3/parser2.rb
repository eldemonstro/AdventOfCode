text = File.open('input.txt').read
text.gsub!(/\r\n?/, "\n")

used_area = Array.new(1000) { Array.new(1000, 0) }
lines = []

text.each_line do |line|
  lines << line
  parsed_line = line.match(/@\s+(\d+),(\d+):\s+(\d+)x(\d+)/)

  width = parsed_line[3].to_i
  height = parsed_line[4].to_i
  x = parsed_line[1].to_i
  y = parsed_line[2].to_i
  end_x = x + width - 1
  end_y = y + height - 1

  (x..end_x).each do |j|
    (y..end_y).each do |i|
      used_area[i][j] += 1
    end
  end
end

not_claimed = ''
this_claim = false

text.each_line do |line|
  this_claim = true

  parsed_line = line.match(/@\s+(\d+),(\d+):\s+(\d+)x(\d+)/)

  width = parsed_line[3].to_i
  height = parsed_line[4].to_i
  x = parsed_line[1].to_i
  y = parsed_line[2].to_i
  end_x = x + width - 1
  end_y = y + height - 1

  (x..end_x).each do |j|
    (y..end_y).each do |i|
      this_claim = false if used_area[i][j] > 1
    end
  end

  if this_claim
    not_claimed = line
  end
end

puts not_claimed
