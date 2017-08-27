class Piece
	attr_reader :player, :points, :color
	attr_accessor :square, :first_move, :moves

  @@grid = nil

  def self.link_to_grid(grid)
    @@grid = grid
  end

	def initialize(input)
		@square        = input.fetch(:square)
    @player        = input.fetch(:player)
    @color         = input.fetch(:color)
    @first_move    = true
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

    def legal_squares(y, x)
      squares = []
      
      #All subclasses of Piece have their own directions instance variable
      @directions.each do |direction|
        next_y = y + direction[0]
        next_x = x + direction[1]
        squares << gather_squares(next_y, next_x, direction) unless self.is_a?(Knight)
        squares << knight_squares(next_y, next_x) if self.is_a?(Knight)
      end

      return squares.flatten
    end

    #A recursive method to gather all legal squares
    def gather_squares(y, x, direction)
      #Base case if coordinates go off of the board   
      return [] if y < 0 || y > 7 || x < 0 || x > 7

      square = grid[y][x]
      
      if square.value.is_a?(Piece) 
        #Base case if a piece is found
        return [] if square.value.color == self.color
        #If square has an opposite color piece then include that square in the returned array
        return [square] if square.value.color != self.color
      else
        next_y = y + direction[0]
        next_x = x + direction[1]

        #Recursively checks next square
        return gather_squares(next_y, next_x, direction) << square
      end
    end

    def knight_squares(y, x)
      #Ensures we don't go off of the board   
      unless y < 0 || y > 7 || x < 0 || x > 7

        square = grid[y][x]
  
        return square if square.value.is_a?(Piece) && square.value.color != self.color
      
        return square if square.value == "_"

        #This value will be flattened in its squares array
        #Without this line the return value would be nil causing a bug
        return [] if square.value.is_a?(Piece) && square.value.color == self.color
      end
    end
end