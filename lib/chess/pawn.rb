class Pawn < Piece
  attr_reader :icon

  def initialize(input)
    super(input)
    @icon = @color == :white ? "\u2659".encode("utf-8") : "\u265F".encode("utf-8")
  end

  private

    def white_moves(y, x)
      moves = []
      forward_one = grid[y - 1][x]
      forward_two = grid[y - 2][x]
      left_diag   = grid[y - 1][x - 1]
      right_diag  = grid[y - 1][x + 1]

      moves << forward_two if first_move && forward_two.value == "_"

      moves << forward_one if forward_one.value == "_"

      moves << left_diag if left_diag.value.is_a?(Piece) && left_diag.value.color == :black

      moves << right_diag if right_diag.value.is_a?(Piece) && right_diag.value.color == :black

      return moves
    end

    def black_moves(y, x)
      moves = []
      forward_one = grid[y + 1][x]
      forward_two = grid[y + 2][x]
      left_diag   = grid[y + 1][x - 1]
      right_diag  = grid[y + 1][x + 1]

      moves << forward_two if first_move && forward_two.value == "_"

      moves << forward_one if forward_one.value == "_"

      moves << left_diag if left_diag.value.is_a?(Piece) && left_diag.value.color == :white

      moves << right_diag if right_diag.value.is_a?(Piece) && right_diag.value.color == :white

      return moves
    end

end
