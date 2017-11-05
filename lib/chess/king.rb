class King < Piece
  attr_reader :directions, :icon

  def initialize(input)
    super(input)
    @directions = [[0, -1], [-1, -1], [-1, 0], [-1, 1],
                   [0, 1], [1, 1], [1, 0], [1, -1]]
    @icon = @color == :black ? "\u2654".encode("utf-8") : "\u265A".encode("utf-8")
  end

  def check?(y, x)
    output = false

    pieces_and_directions = {
      :bishop => [[-1, -1], [-1, 1], [1, -1], [1, 1]],
      :rook   => [[0, -1], [-1, 0], [0, 1], [1, 0]],
      :queen  => [[0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1]]
    }

    pieces_and_directions.each do |type, directions|
      directions.each do |direction|
        next_y = y + direction[0]
        next_x = x + direction[1]
        output = true if line_of_fire?(next_y, next_x, direction, type)
      end
    end

    output = true if threatened_by_knight?(y, x)

    return output
  end

  private

    def line_of_fire?(y, x, direction, type)
      #Base case if coordinates go off of the board
      return false if y < 0 || y > 7 || x < 0 || x > 7

      square = grid[y][x]
      piece  = square.value

      if piece.is_a?(Piece)
        if piece.is_a?(Rook) && type == :rook
          return threat?(piece)
        elsif piece.is_a?(Queen) && type == :queen
          return threat?(piece)
        elsif piece.is_a?(Bishop) && type == :bishop
          return threat?(piece)
        elsif piece.color == self.color || piece.is_a?(Knight) || piece.is_a?(Pawn) || piece.is_a?(King)
          return false
        end
      else
        next_y = y + direction[0]
        next_x = x + direction[1]

        return line_of_fire?(next_y, next_x, direction, type)
      end
    end


=begin
      if piece.is_a?(type)
        if square.value.color == self.color
          return false
        elsif square.value.color != self.color
          return true
        end
      else
=end
    def threat?(piece)
      return true if piece.color != self.color
      return false
    end

    def threatened_by_knight?(y, x)
      output = false
      surrounding_knight_squares = [[-2, -1], [-2, 1], [-1, 2], [1, 2],
                                    [2, 1], [2, -1], [1, -2], [-1, -2]]

      surrounding_knight_squares.each do |direction|
        next_y = y + direction[0]
        next_x = x + direction[1]

        output = true if knight?(next_y, next_x)
      end

      return output
    end

    def knight?(y, x)
      #Ensures we don't go off of the board
      unless y < 0 || y > 7 || x < 0 || x > 7

        square = grid[y][x]

        return true if square.value.is_a?(Knight) && square.value.color != self.color
      end
    end

    def king_squares(y, x)
      unless y < 0 || y > 7 || x < 0 || x > 7
        square = grid[y][x]
        value  = square.value

        if value.is_a?(Piece)
          piece = value
          update_protected_pieces(piece) if piece.color == self.color
          return square unless piece.color == self.color || enemy_attacking?(square) || piece.protected?
        elsif square.attacked_by.has_king?(self)
          enforce_opposition(square)
        else
          return square
        end
      end

      return []
    end

    def enemy_attacking?(square)
      return true if square.attacked_by.any? { |piece| piece.color != self.color  }
      return false
    end

    #Opposition in Chess is when neither king can move to a square next
    #to the other king
    #This method removes squares from one player's king if the other player's
    #king found those same squares right next to it
    #This ensures both kings aren't breaking the rules of opposition
    def enforce_opposition(square)
      king = square.attacked_by.select { |piece| piece.is_a?(King) }[0]
      king.moves.delete(square)
    end
end
