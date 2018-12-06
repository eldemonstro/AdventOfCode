final_result = 0;
text = File.open('input.txt').read
text.gsub!(/\r\n?/, "\n")
three_times = 0;
two_times = 0;
have_a_three = false;
have_a_two = false;

text.each_line do |line|
  letters = line.split('')
  uniques = letters.uniq

  letters.each do |letter|
    count = letters.count(letter)
    have_a_three = true if count == 3
    have_a_two = true if count == 2
  end

  three_times += 1 if have_a_three == true
  two_times += 1 if have_a_two == true

  have_a_three = false
  have_a_two = false
end

puts three_times
puts two_times

final_result = two_times * three_times
puts final_result
