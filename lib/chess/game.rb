class Game  
  attr_reader :board

  def initialize(input)
    @players = input.fetch(:players)
    @board   = Board.new
  end
end