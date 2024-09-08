input = File.read("input.txt").split("\n")
line_length = input.first.length - 1
line_count = input.count - 1
symbols = ["=", "*", "+", "/", "&", "#", "-", "%", "$", "@"]
separators = [".", "=", "*", "+", "/", "&", "#", "-", "%", "$", "@"]
pattern = Regexp.union(separators)
special_pattern = Regexp.union(symbols)
valid_part_numbers = []
input.each_with_index do |line, index|
  numbers = line.gsub(pattern, ',').split(',').delete_if { |a| a.empty? }
  numbers.each do |number|
    start_index = line.index(number)
    end_index = start_index + number.length - 1
    left = if start_index == 0
             '.'
           else
             line[start_index - 1]
           end
    right = if end_index == line_length
              '.'
            else
              line[end_index + 1]
            end
    upper_line = if index == 0
                   '.'
                 else
                   input[index - 1][(start_index - 1)..(end_index + 1)]
                 end

    lower_line = if index == line_count
                   '.'
                 else
                   input[index + 1][([1, start_index].max - 1)..([end_index, line_length].min + 1)]
                 end
    if (left + right + upper_line + lower_line).scan(special_pattern).count != 0
      valid_part_numbers << number
    end
    line[start_index..end_index] = ('.' * number.length)
  end
end
puts valid_part_numbers.sum { |part_number| part_number.to_i }
