require "spec_helper"

describe Pawn do 
  let(:square)       { Square.new }
  let(:player)       { Player.new("Zach", :white) }
  let(:other_player) { Player.new("Lauren", :black) }

  describe "#initialize" do 
    context "when given correct number of arguments" do 
      it "doesn't raise exception" do 
        expect { Pawn.new(:square => square,
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
    it "contains legal moves for white player" do 
      grid = [[Square.new, Square.new, Square.new],
              [Square.new, Square.new, Square.new],
              [Square.new, square, Square.new]]
      
      #Has all pieces link to the grid
      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square, :player => player)

      #Pawn's starting position for this example
      grid[2][1].value = pawn 

      legal_moves = [grid[0][1], grid[1][1]]

      #gathers all legal moves for the pawn instance(stores result in @moves)
      pawn.find_moves

      expect(pawn.moves).to match_array(legal_moves)
    end

    it "contains legal moves for black player" do 
      grid = [[Square.new, square, Square.new],
              [Square.new, Square.new, Square.new],
              [Square.new, Square.new, Square.new]]

      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square, :player => other_player)

      square.value = pawn #Pawn's starting position for this example

      legal_moves = [grid[1][1], grid[2][1]]

      pawn.find_moves

      expect(pawn.moves).to match_array(legal_moves)
    end

    it "recognizes enemies at diagonals for white player" do 
      grid = [[Square.new, Square.new, Square.new],
              [Square.new, Square.new, Square.new],
              [Square.new, square, Square.new]]

      #Sets left diagonal to contain enemy piece
      grid[1][0].value = Piece.new(:square => grid[1][0], :player => other_player)

      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square, :player => player)

      square.value = pawn 

      legal_moves = [grid[0][1], grid[1][1], grid[1][0]]

      pawn.find_moves

      expect(pawn.moves).to match_array(legal_moves)
    end

    it "recognizes enemies at diagonals for black player" do 
      grid = [[Square.new, square, Square.new],
              [Square.new, Square.new, Square.new],
              [Square.new, Square.new, Square.new]]

      #Sets left diagonal to contain enemy piece
      grid[1][0].value = Piece.new(:square => grid[1][0], :player => player)

      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square, :player => other_player)

      square.value = pawn 

      legal_moves = [grid[1][1], grid[2][1], grid[1][0]]

      pawn.find_moves

      expect(pawn.moves).to match_array(legal_moves)
    end
  end

  describe "#move" do 
    context "when given illegal square" do 
      it "returns false" do 
        grid = [[Square.new, Square.new, Square.new],
                [Square.new, Square.new, Square.new],
                [Square.new, square, Square.new]]
        
        Piece.link_to_grid(grid)

        pawn = Pawn.new(:square => square, :player => player)

        square.value = pawn 

        legal_moves = [grid[0][1], grid[1][1]]

        pawn.find_moves

        expect(pawn.move(grid[0][2])).to eq false
      end
    end
    
    it "moves piece to a legal square" do 
      grid = [[Square.new, Square.new, Square.new],
              [Square.new, Square.new, Square.new],
              [Square.new, square, Square.new]]
      
      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square, :player => player)

      square.value = pawn 

      legal_moves = [grid[0][1], grid[1][1]]

      pawn.find_moves

      pawn.move(grid[0][1])

      expect(grid[0][1].value).to eq pawn
    end

    it "piece's square changes as expected" do 
      grid = [[Square.new, Square.new, Square.new],
              [Square.new, Square.new, Square.new],
              [Square.new, square, Square.new]]
      
      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square, :player => player)

      square.value = pawn 

      legal_moves = [grid[0][1], grid[1][1]]

      pawn.find_moves

      pawn.move(grid[0][1])

      expect(pawn.square).to eq grid[0][1]
    end
  end
end
