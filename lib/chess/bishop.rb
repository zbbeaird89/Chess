require 'pry'

class Bishop < Piece
  attr_accessor :moves

  def initialize(input)
    super(input)
    @moves = []
  end

  def find_moves
    super
  end

  private 

    def legal_squares(y, x)
      directions = [[-1, -1], [-1, 1], 
               [1, -1], [1, 1]]

      directions.each do |direction|
        @moves << gather_squares(y, x, direction[0], direction[1])
      end

      @moves.flatten
    end

    def gather_squares(y, x, ynum, xnum)

      return [] if y + ynum < 0 || y + ynum > 2 || x + xnum < 0 || x + xnum > 2

      square = grid[y + ynum][x + xnum]

      if square.value.is_a?(Piece)
        return [] if square.value.player.color != player.color
      end

      ynum = ynum + ynum
      xnum = xnum + xnum
      
      return gather_squares(y, x, ynum, xnum).push(square)
    end
end