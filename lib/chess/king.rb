class King < Piece
  attr_reader :directions

  def initialize(input)
    super(input)
    @directions = [[-1, 0], [1, 0], [0, -1], [0, 1],
                   [-1, -1], [-1, 1], [1, 1], [1, -1],
                   [-2, -1], [-2, 1], [-1, 2], [1, 2],
                   [2, 1], [2, -1], [1, -2], [-1, -2]]
  end

  def check?(square = self.square)
    square.attacked? ? true : false
  end

  private

    def king_squares(y, x)
      unless y < 0 || y > 7 || x < 0 || x > 7
        square = grid[y][x]
        value  = square.value

        return square unless square.attacked? 
      end
    end


    #king could attack an enemy piece but that piece could be protected making it an illegal
    #square


    #gather legal squares for both kings and then check to see if they have any common squares and 
    #set @attacked to false and remove those squares from king.moves
end