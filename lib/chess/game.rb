class Game  
  attr_reader :board, :players, :player1, :player2

  def initialize(input)
    @players = input.fetch(:players)
    @player1 = @players[0]
    @player2 = @players[1]
    @board   = Board.new
  end
end