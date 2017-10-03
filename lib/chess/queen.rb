class Queen < Piece
  attr_reader :directions, :icon

  def initialize(input)
    super(input)
    @directions = [[0, -1], [-1, -1], [-1, 0], [-1, 1],
                   [0, 1], [1, 1], [1, 0], [1, -1]]
    @icon   = @color == :black ? "\u2655".encode("utf-8") : "\u265B".encode("utf-8")
    @points = 9
  end
end
