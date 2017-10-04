class Pawn < Piece
  attr_reader :icon

  def initialize(input)
    super(input)
    @icon = @color == :black ? "\u2659".encode("utf-8") : "\u265F".encode("utf-8")
  end

  private

    def white_moves(y, x)
      moves = []

      sqs = squares_on_board(y, x)

      if sqs[:forward_two]
        if sqs[:first_move] && sqs[:forward_two].value == "_"
          moves << sqs[:forward_two]
        end
      end

      if sqs[:forward_one]
        if sqs[:forward_one].value == "_"
          moves << sqs[:forward_one]
        end
      end

      if sqs[:left_diag]
        if sqs[:left_diag].value.is_a?(Piece) && sqs[:left_diag].value.color == :black
          moves << sqs[:left_diag]
        end
      end

      if sqs[:right_diag]
        if sqs[:right_diag].value.is_a?(Piece) && sqs[:right_diag].value.color == :black
          moves << sqs[:right_diag]
        end
      end

      return moves
    end

    def black_moves(y, x)
      moves = []

      sqs = squares_on_board(y, x)

      if sqs[:forward_two]
        if sqs[:first_move] && sqs[:forward_two].value == "_"
          moves << sqs[:forward_two]
        end
      end

      if sqs[:forward_one]
        if sqs[:forward_one].value == "_"
          moves << sqs[:forward_one]
        end
      end

      if sqs[:left_diag]
        if sqs[:left_diag].value.is_a?(Piece) && sqs[:left_diag].value.color == :white
          moves << sqs[:left_diag]
        end
      end

      if sqs[:right_diag]
        if sqs[:right_diag].value.is_a?(Piece) && sqs[:right_diag].value.color == :white
          moves << sqs[:right_diag]
        end
      end

      return moves
    end

    #Eliminates squares checked off of the board
    def squares_on_board(y, x)
      directions = {}

      directions[:forward_one] = grid[y + 1][x] unless y + 1 > 7
      directions[:forward_two] = grid[y + 2][x] unless y + 2 > 7
      directions[:left_diag]   = grid[y + 1][x - 1] unless y + 1 > 7 || x - 1 < 0
      directions[:right_diag]  = grid[y + 1][x + 1] unless y + 1 > y || x + 1 > 7

      return directions
    end

end
