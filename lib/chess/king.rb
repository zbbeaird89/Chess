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
        elsif square.attacked_by.has_king?
          enforce_opposition(square)
        else
          return square unless square.attacked?
        end
      end

      return []
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
