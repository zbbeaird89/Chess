class Bishop < Piece
  attr_reader :directions

  def initialize(input)
    super(input)
    @directions = [[-1, -1], [-1, 1], 
                   [1, -1], [1, 1]] 
    @points = 3
  end
end