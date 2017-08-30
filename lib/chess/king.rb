class King < Piece
  attr_reader :directions

  def initialize(input)
    super(input)
    @directions = {
      :up_and_down    => [[-1, 0], [1, 0]],
      :left_and_right => [[0, -1], [0, 1]],
      :diagonals      => [[-1, -1], [-1, 1], [1, 1], [1, -1]],
      :knight_squares => [[-2, -1], [-2, 1], [-1, 2], [1, 2],
                          [2, 1], [2, -1], [1, -2], [-1, -2]]
    }
  end

=begin
  def check?(square)
    squares_to_directions = scan_all_directions(square)

    squares_to_directions.each do |direction, square|
    
      if direction == :up_and_down
        return true if 
      end

    end

    
  end

  private

    def scan_all_directions(square)
      output = {}

      y, x = grid.coordinates(square)

      #Write an algorithm that checks for attacking pieces.
      @directions.each do |direction, iterators|
        iterators.each do |nums| do 
          next_y = y + nums[0]
          next_x = x + nums[1]

          if direction == :knight_squares
            output[direction] = knight_squares(next_y, next_x) 
          else
            output[direction] = gather_squares(next_y, next_x, nums)     
          end
        end

        output[direction].flatten
      end

      return output
    end


    def king_squares(y, x)

      unless y < 0 || y > 7 || x < 0 || x > 7
        square = grid[y][x]

        #check?(y, x)
        return square unless check?(square)

      end
    end
=end
end