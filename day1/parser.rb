final_result = 0;
text = File.open('numbers.txt').read
text.gsub!(/\r\n?/, "\n")
text.each_line do | line |
  final_result += line.to_i
end
puts final_result
