require "spec_helper"

describe Bishop do 
  let(:square)       { Square.new }
  let(:player)       { Player.new("Zach", :white) }
  let(:other_player) { Player.new("Lauren", :black) }

  describe "#initialize" do 
    context "when given correct number of arguments" do 
      it "doesn't raise exception" do 
        expect { Bishop.new(:square => square,
                            :player => player) }.to_not raise_error
      end
    end

    context "when given wrong number of arguments" do 
      it "raises 'KeyError'" do 
        expect { Pawn.new(:player => player) }.to raise_error(KeyError)
      end
    end
  end

  describe "#grid" do 
    it "can read the grid" do 
      grid = [["", "", ""],
              ["", "", ""],
              ["", "", ""]]

      Piece.link_to_grid(grid)

      bishop = Bishop.new(:square => square, :player => player)

      expect(bishop.grid).to eq grid
    end
  end

  describe "#square" do 
    it "can read the square" do 
      grid = [["", "", ""],
              ["", "", ""],
              ["", "", ""]]

      Piece.link_to_grid(grid)

      bishop = Bishop.new(:square => square, :player => player)

      expect(bishop.square).to eq square
    end
  end

  describe "#player" do 
    it "can read the player" do 
      grid = [["", "", ""],
              ["", "", ""],
              ["", "", ""]]

      Piece.link_to_grid(grid)

      bishop = Bishop.new(:square => square, :player => player)

      expect(bishop.player).to eq player
    end
  end

  describe "#moves" do 
    context "when all directions contain only empty squares" do 
      it "contains legal squares" do 
        grid = [[Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                [Square.new, Square.new, Square.new, square, Square.new, Square.new, Square.new, Square.new],
                [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new]]
        
        #Has all pieces link to the grid
        Piece.link_to_grid(grid)

        bishop = Bishop.new(:square => square, :player => player)

        #Bishop's starting position for this example
        grid[3][3].value = bishop 

        legal_moves = [grid[0][0], grid[1][1], grid[2][2], grid[4][4], grid[5][5], grid[6][6],
                       grid[7][7], grid[4][2], grid[5][1], grid[6][0], grid[2][4], grid[1][5],
                       grid[0][6]]

        #gathers all legal moves for the bishop instance(stores result in @moves)
        bishop.find_moves

        expect(bishop.moves).to match_array(legal_moves)
      end
    end
  end
end

#3, 3