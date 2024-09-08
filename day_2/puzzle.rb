require 'debug'
input = File.read('input.txt').split("\n")
red = 12
green = 13
blue = 14
sum = 0
input.each do |game|
  game_id = game.split(",").first.to_i
  valid_game = true
  game.split(",")[1..-1].join(",").split(";").each do |grab|
    grab.split(",").each do |gems|
      color = gems.scan(/[a-zA-Z]+/).first
      count = gems.scan(/\d/).join("").to_i
      valid_game = false if (count > eval(color)) rescue binding.irb
    end
  end
  sum += game_id if valid_game
end
puts sum
