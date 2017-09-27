class Board
  attr_reader :grid, :squares

  def initialize
   @grid = default_grid
   @squares = notations_to_squares(@grid)
  end

  def formatted_grid
    @grid.each_with_index do |row, i|
      output = row.map do |sq|
        sq.value.is_a?(Piece) ? sq.value.icon : sq.value
      end
      puts "#{8 - i}   " + output.join("|")
    end
    puts ""
    puts "    A B C D E F G H"
  end

  private

    def default_grid
      Array.new(8) { Array.new(8) { Square.new } }
    end

    def notations_to_squares(grid)
      {
        "A1" => grid[7][0],
        "A2" => grid[6][0],
        "A3" => grid[5][0],
        "A4" => grid[4][0],
        "A5" => grid[3][0],
        "A6" => grid[2][0],
        "A7" => grid[1][0],
        "A8" => grid[0][0],
        "B1" => grid[7][1],
        "B2" => grid[6][1],
        "B3" => grid[5][1],
        "B4" => grid[4][1],
        "B5" => grid[3][1],
        "B6" => grid[2][1],
        "B7" => grid[1][1],
        "B8" => grid[0][1],
        "C1" => grid[7][2],
        "C2" => grid[6][2],
        "C3" => grid[5][2],
        "C4" => grid[4][2],
        "C5" => grid[3][2],
        "C6" => grid[2][2],
        "C7" => grid[1][2],
        "C8" => grid[0][2],
        "D1" => grid[7][3],
        "D2" => grid[6][3],
        "D3" => grid[5][3],
        "D4" => grid[4][3],
        "D5" => grid[3][3],
        "D6" => grid[2][3],
        "D7" => grid[1][3],
        "D8" => grid[0][3],
        "E1" => grid[7][4],
        "E2" => grid[6][4],
        "E3" => grid[5][4],
        "E4" => grid[4][4],
        "E5" => grid[3][4],
        "E6" => grid[2][4],
        "E7" => grid[1][4],
        "E8" => grid[0][4],
        "F1" => grid[7][5],
        "F2" => grid[6][5],
        "F3" => grid[5][5],
        "F4" => grid[4][5],
        "F5" => grid[3][5],
        "F6" => grid[2][5],
        "F7" => grid[1][5],
        "F8" => grid[0][5],
        "G1" => grid[7][6],
        "G2" => grid[6][6],
        "G3" => grid[5][6],
        "G4" => grid[4][6],
        "G5" => grid[3][6],
        "G6" => grid[2][6],
        "G7" => grid[1][6],
        "G8" => grid[0][6],
        "H1" => grid[7][7],
        "H2" => grid[6][7],
        "H3" => grid[5][7],
        "H4" => grid[4][7],
        "H5" => grid[3][7],
        "H6" => grid[2][7],
        "H7" => grid[1][7],
        "H8" => grid[0][7],
      }
    end
end
