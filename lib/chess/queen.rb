class Queen < Piece
  attr_reader :directions

  def initialize(input) 
    super(input)
    @directions = [[0, -1], [-1, -1], [-1, 0], [-1, 1], 
                   [0, 1], [1, 1], [1, 0], [1, -1]] 
    @points = 9
  end
end