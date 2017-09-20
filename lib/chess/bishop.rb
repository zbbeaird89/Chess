class Bishop < Piece
  attr_reader :directions, :icon

  def initialize(input)
    super(input)
    @directions = [[-1, -1], [-1, 1],
                   [1, -1], [1, 1]]
    @icon   = @color == :white ? "\u2657".encode("utf-8") : "\u265D".encode("utf-8")
    @points = 3
  end
end
