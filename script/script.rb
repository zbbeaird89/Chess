require_relative "../lib/chess.rb"

puts "Welcome to Chess!"

puts "Press (1) for 1 Player or press (2) for 2 Players"

number = gets.chomp

player1 = nil

player2 = nil


if number.to_i == 2

  puts "What is Player 1's name?"

  name = gets.chomp

  player1 = Player.new(name, :white)

  puts "What is Player 2's name?"

  name = gets.chomp

  player2 = Player.new(name, :black)

end


players = [player1, player2]

Game.new(:players => players).play
