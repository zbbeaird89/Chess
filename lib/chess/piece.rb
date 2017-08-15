class Piece
	attr_reader :player, :points
	attr_accessor :square, :origin_square

  @@grid = nil

  def self.link_to_grid(grid)
    @@grid = grid
  end

	def initialize(input)
		@square        = input.fetch(:square)
    @player        = input.fetch(:player)
    @origin_square = true
    @points        = 1
	end

  def grid
    @@grid
  end

  def move(to_square)
    from_square = self.square # Stores From square

    capture_piece(self.player, to_square.value) if to_square.value.is_a?(Piece)

    to_square.value   = self        # Updates square argument's value to piece
    self.square       = to_square   # Piece's new square is the square argument
    from_square.value = "_"         # From square value is updated to blank
    self.origin_square = false
  end

  private

    def capture_piece(player, piece)
      player.points += piece.points
    end
end