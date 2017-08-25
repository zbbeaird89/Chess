class Piece
	attr_reader :player, :points
	attr_accessor :square, :first_move, :moves

  @@grid = nil

  def self.link_to_grid(grid)
    @@grid = grid
  end

	def initialize(input)
		@square        = input.fetch(:square)
    @player        = input.fetch(:player)
    @first_move = true
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
    self.first_move = false
  end

  def find_moves
    y, x = grid.coordinates(@square)
    @moves = pawn_moves(y, x) if self.is_a?(Pawn)

    #All subclasses of Piece (other than Pawn) have their own legal_moves method
    #This line of code responds to whatever Piece is doing the calling
    @moves = legal_squares(y, x) unless self.is_a?(Pawn)
  end

  private

    def pawn_moves(y, x)
      return white_moves(y, x) if @player.color == :white
      return black_moves(y, x) if @player.color == :black
    end

    def capture_piece(player, piece)
      player.points += piece.points
    end
end