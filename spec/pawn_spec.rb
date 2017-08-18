require "spec_helper"

describe Pawn do 
  let(:square) { Square.new }
  let(:player) { Player.new("Zach", :white) }

  describe "#initialize" do 
    context "when given correct number of arguments" do 
      it "doesn't raise exception" do 
        expect { Pawn.new(:square => square,
                          :player => player) }.to_not raise_error
      end
    end

    context "when given wrong number of arguments" do 
      it "raises 'ArgumentError'" do 
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

      pawn = Pawn.new(:square => square, :player => player)

      expect(pawn.grid).to eq grid
    end
  end

  describe "#square" do 
    it "can read the square" do 
      pawn = Pawn.new(:square => square, :player => player)
      expect(pawn.square).to eq square
    end
  end

  describe "#player" do 
    it "can read the player" do 
      pawn = Pawn.new(:square => square, :player => player)
      expect(pawn.player).to eq player
    end
  end

  describe "#moves" do 
    it "contains legal moves" do 
      grid = [[Square.new, Square.new, Square.new],
              [Square.new, Square.new, Square.new],
              [Square.new, square, Square.new]]

      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square, :player => player)

      grid[2][1].value = pawn #Pawn's starting position for this example

      legal_moves = [grid[0][1], grid[1][1]]

      pawn.find_moves(square, player)

      expect(pawn.moves).to match_array(legal_moves)
    end
  end
end


# Fix square