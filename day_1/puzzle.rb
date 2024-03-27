require "debug"
codes = File.read('codes.txt').split("\n")

def str_to_number(str)
  hash_numbers = {
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }
  positions_arr = []
  hash_numbers.each do |key, value|
    str.enum_for(:scan, /#{key}/).map do
      positions_arr << {
        key => Regexp.last_match.begin(0)
      }
    end
  end
  positions_arr.sort_by! { |hsh| hsh.values }

  numbers = str.scan(/\d/).join("").split("")

  first_number_position = str.index(numbers[0]) rescue nil
  last_number_position = str.size - str.reverse.index(numbers[-1]) rescue nil

  first = positions_arr.first
  last = positions_arr.last
  # debugger if str == '422268'
  unless positions_arr.empty? or (first_number_position && first_number_position < first.first[1])
    str.sub!(/#{first.keys.first}/, hash_numbers[first.keys.first].to_s)
  end
  unless positions_arr.empty? or (last_number_position && last_number_position > last.first[1])
    str.sub!(/#{last.keys.first}/, hash_numbers[last.keys.first].to_s)
  end
  if !positions_arr.empty?
    if first_number_position && first_number_position < first.first[1]
      if last_number_position && last_number_position > last.first[1]
      else
        if first != last
          str.gsub!(/#{last.keys.first}/, hash_numbers[last.keys.first].to_s)
        end
      end
    else
      str.sub!(/#{first.keys.first}/, hash_numbers[first.keys.first].to_s)
    end
    if (first.values.first + first.keys.first.size) < (last.values.first + 1) && first != last
      str.gsub!(/#{last.keys.first}/, hash_numbers[last.keys.first].to_s)
    end
  end
  str
end

sum = 0
codes.map do |code|
  puts code
  sanitazed_code = str_to_number(code)
  numbers = sanitazed_code.scan(/\d/).join("")
  puts numbers
  first_number = numbers[0]
  last_number = numbers[-1]
  calibration_code = "#{first_number}#{last_number}".to_i
  puts calibration_code
  puts "\n"
  sum += calibration_code
end

puts sum

# p str_to_number("eightwothree")