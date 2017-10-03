class King < Piece
  attr_reader :directions, :icon

  def initialize(input)
    super(input)
    @directions = [[0, -1], [-1, -1], [-1, 0], [-1, 1],
                   [0, 1], [1, 1], [1, 0], [1, -1]]
    @icon = @color == :black ? "\u2654".encode("utf-8") : "\u265A".encode("utf-8")
  end

  def check?
    self.square.attacked?
  end

  private

    def king_squares(y, x)
      unless y < 0 || y > 7 || x < 0 || x > 7
        square = grid[y][x]
        value  = square.value

        if value.is_a?(Piece)
          piece = value
          update_protected_pieces(piece) if piece.color == self.color
          return square unless piece.color == self.color || square.attacked?
        else
          return square unless square.attacked?
        end
      end

      return []
    end


    #gather legal squares for both kings and then check to see if they have any common squares and
    #set @attacked to false and remove those squares from king.moves
end
