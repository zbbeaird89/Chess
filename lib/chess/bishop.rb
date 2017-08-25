require 'pry-nav'
require 'pry'

class Bishop < Piece

  def initialize(input)
    super(input)
  end

  def find_moves
    super
  end

  private 

    def legal_squares(y, x)
      squares = []
      directions = [[-1, -1], [-1, 1], 
                    [1, -1], [1, 1]]

      directions.each do |direction|
        next_y = y + direction[0]
        next_x = x + direction[1]
        squares << gather_squares(next_y, next_x, direction)
      end

      return squares.flatten
    end

    def gather_squares(y, x, direction)   
      return [] if y < 0 || y > 7 || x < 0 || x > 7

      square = grid[y][x]
  
      if square.value.is_a?(Piece)
        return [] if square.value.player.color != player.color
      end

      next_y = y + direction[0]
      next_x = x + direction[1]
      
      return gather_squares(next_y, next_x, direction) << square
    end
end