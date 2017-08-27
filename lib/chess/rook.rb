class Rook < Piece
  attr_reader :directions

  def initialize(input) 
    super(input)
    @directions = [[0, -1], [-1, 0], 
                   [0, 1], [1, 0]]
    @points = 5
  end
end