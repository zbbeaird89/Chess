class Queen < Piece

  def initialize(input) 
    super(input)
  end

  def find_moves
    super
  end

  private 

    def legal_squares(y, x)
      squares = []
      directions = [[0, -1], [-1, -1], [-1, 0], [-1, 1], 
                    [0, 1], [1, 1], [1, 0], [1, -1]]

      directions.each do |direction|
        next_y = y + direction[0]
        next_x = x + direction[1]
        squares << gather_squares(next_y, next_x, direction)
      end

      return squares.flatten
    end

    #A recursive method to gather all legal squares
    def gather_squares(y, x, direction)
      #Base case if coordinates go off of the board   
      return [] if y < 0 || y > 7 || x < 0 || x > 7

      square = grid[y][x]
      
      if square.value.is_a?(Piece) 
        #Base case if a piece is found
        return [] if square.value.color == self.color
        #If square has an opposite color piece then include that square in the returned array
        return [square] if square.value.color != self.color
      else
        next_y = y + direction[0]
        next_x = x + direction[1]

        #Recursively checks next square
        return gather_squares(next_y, next_x, direction) << square
      end
    end
end