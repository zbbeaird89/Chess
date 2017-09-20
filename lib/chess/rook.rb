class Rook < Piece
  attr_reader :directions, :icon

  def initialize(input)
    super(input)
    @directions = [[0, -1], [-1, 0],
                   [0, 1], [1, 0]]
    @icon   = @color == :white ? "\u2656".encode("utf-8") : "\u265C".encode("utf-8")
    @points = 5
  end
end
