require "pry"

class Piece
	attr_reader   :player, :points, :color
	attr_accessor :square, :first_move, :moves, :protected_by, :protected, :protecting
  alias_method  :protected?, :protected

  @@grid = nil

  def self.link_to_grid(grid)
    @@grid = grid
  end

	def initialize(input)
		@square        = input.fetch(:square)
    @player        = input.fetch(:player)
    @color         = input.fetch(:color)
    @first_move    = true
    @protected_by  = []
    @protecting    = []
    @moves         = []
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

    clear_protected_pieces

    squares = self.is_a?(Pawn) ? pawn_moves(y, x) : legal_squares(y, x)

    discard_squares(squares)

    assign_attacker(squares)
    
    @moves = squares
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
        
        squares << gather_squares(next_y, next_x, direction) unless self.is_a?(Knight) || self.is_a?(King)
        squares << king_squares(next_y, next_x) if self.is_a?(King)
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
        if square.value.color == self.color
          update_protected_pieces(square.value)
          return []
        elsif square.value.color != self.color
          return [square] 
        end
      else  
        next_y = y + direction[0]
        next_x = x + direction[1]

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
        if square.value.is_a?(Piece) && square.value.color == self.color
          update_protected_pieces(square.value)
          return [] 
        end
      else
        #If we go off the grid
        #The value will be flattened in its squares array
        #Without this line the return value would be nil causing a bug
        return []
      end
    end

    #Any pieces that were once protected by self are deleted
    def clear_protected_pieces
      self.protecting.each do |piece| 
        piece.protected_by.delete(self) 
        piece.protected = false if piece.protected_by.empty?
      end

      self.protecting.clear
    end

    def update_protected_pieces(piece)
      piece.protected_by.push(self) 
      piece.protected = true
      self.protecting.push(piece) 
    end

    def discard_squares(squares)  
      peaceful_squares = @moves - squares
      peaceful_squares.each { |sq| sq.attacked_by.delete(self) }
    end

    def assign_attacker(squares)    
      squares.each { |sq| sq.attacked_by.push(self) }
    end
end



# Look into if some of the methods need to be protected