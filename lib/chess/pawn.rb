class Pawn < Piece
  attr_accessor :moves

  def initialize(input)
    super(input)
  end

  def find_moves
    super
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

      moves << left_diag if left_diag.value.is_a?(Piece) && left_diag.value.player.color == :black

      moves << right_diag if right_diag.value.is_a?(Piece) && right_diag.value.player.color == :black

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

      moves << left_diag if left_diag.value.is_a?(Piece) && left_diag.value.player.color == :white

      moves << right_diag if right_diag.value.is_a?(Piece) && right_diag.value.player.color == :white

      return moves
    end

end