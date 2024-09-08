require 'debug'
input = File.read('input.txt').split("\n")
# red = 12
# green = 13
# blue = 14
sum = 0
input.each do |game|
  game_id = game.split(",").first.to_i
  valid_game = true
  red = 0
  green = 0
  blue = 0
  game.split(",")[1..-1].join(",").split(";").each do |grab|
    grab.split(",").each do |gems|
      color = gems.scan(/[a-zA-Z]+/).first
      count = gems.scan(/\d/).join("").to_i
      if count > eval(color)
        eval("#{color} = #{count}")
      end
    end
  end
  sum += (red * green * blue)
end
puts sum
