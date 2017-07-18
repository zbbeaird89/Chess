class Piece
	attr_reader :grid, :player
	attr_accessor :square

	def initialize(input)
		@grid   = input.fetch(:grid)
		@square = input.fetch(:square)
    @player = input.fetch(:player)
	end

  def move(square)
    origin_square = self.square # Stores original square
    square.value  = self        # Updates square argument's value to piece
    self.square   = square      # Piece's new square is the square argument
    origin_square.value = "_"   # Original square value is updated to blank
  end
end