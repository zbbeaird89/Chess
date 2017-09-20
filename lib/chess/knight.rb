class Knight < Piece
  attr_reader :points, :icon

  def initialize(input)
    super(input)
    @directions = [[-2, -1], [-2, 1], [-1, 2], [1, 2],
                   [2, 1], [2, -1], [1, -2], [-1, -2]]
    @icon   = @color == :white ? "\u2658".encode("utf-8") : "\u265E".encode("utf-8") 
    @points = 3
  end
end
