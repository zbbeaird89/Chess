require_relative "../lib/chess.rb"

puts "Welcome to Chess!"

puts "Press (1) for New Game or press (2) to Load Game"

number = gets.chomp

player1 = nil

player2 = nil


if number.to_i == 1

  puts "What is Player 1's name?"

  name = gets.chomp

  player1 = Player.new(name, :white)

  puts "What is Player 2's name?"

  name = gets.chomp

  player2 = Player.new(name, :black)

  players = [player1, player2]

  Game.new(:players => players).play

elsif number.to_i == 2
  puts "Which game would you like to load? [1, 2, 3]"

  input = gets.chomp
  file  = File.read("save_files/save#{input}.yml")
  game  = YAML::load(file)

  #Yaml loses all class variable references.
  #Because of this all pieces will lose their reference to @@grid
  #This line reassigns @@grid in the Piece class
  Piece.link_to_grid(game.board.grid)

  game.play
end
