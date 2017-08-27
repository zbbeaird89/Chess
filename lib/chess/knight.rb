class Knight < Piece
  attr_reader :points

  def initialize(input)
    super(input)
    @directions = [[-2, -1], [-2, 1], [-1, 2], [1, 2],
                   [2, 1], [2, -1], [1, -2], [-1, -2]]
    @points     = 3
  end
end