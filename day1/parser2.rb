final_result = 0;
results = [];
repeat = true;
text = File.open('numbers.txt').read
text.gsub!(/\r\n?/, "\n")

while(repeat)
  text.each_line do | line |
    final_result += line.to_i
    if results.include?(final_result)
      repeat = false
      break
    end
    results << final_result
  end
end

puts final_result
