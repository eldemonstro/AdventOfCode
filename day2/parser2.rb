final_result = ""
text = File.open('input.txt').read
text.gsub!(/\r\n?/, "\n")
one_letter_code = []


text.each_line do |line|
  letters = line.split('')

  text.each_line do |comparable_line|
    comparable_letters = comparable_line.split('')

    next if comparable_line == line

    bank_diff_letters = []

    letters.each_with_index do |letter, index|
      next if comparable_letters[index] == letter
      bank_diff_letters << letter
    end

    if bank_diff_letters.length != 1
      bank_diff_letters = []
    else
      letters.delete bank_diff_letters[0]
      final_result = letters.join('')
      break
    end
  end
end

puts final_result
