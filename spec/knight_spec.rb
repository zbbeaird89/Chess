require "spec_helper"

describe Knight do 
  let(:square)       { Square.new }
  let(:player)       { Player.new("Zach", :white) }
  let(:other_player) { Player.new("Lauren", :black) }

  describe "#initialize" do 
    context "when given correct number of arguments" do 
      it "doesn't raise exception" do 
        expect { Knight.new(:square => square,
                          :player => player,
                          :color  => player.color) }.to_not raise_error
      end
    end

    context "when given wrong number of arguments" do 
      it "raises 'KeyError'" do 
        expect { Knight.new(:player => player) }.to raise_error(KeyError)
      end
    end
  end

  describe "#grid" do 
    it "can read the grid" do 
      grid = [["", "", ""],
              ["", "", ""],
              ["", "", ""]]

      Piece.link_to_grid(grid)

      knight = Knight.new(:square => square, 
                          :player => player,
                          :color  => player.color)

      expect(knight.grid).to eq grid
    end
  end

  describe "#square" do 
    it "can read the square" do 
      knight = Knight.new(:square => square, 
                          :player => player,
                          :color  => player.color)

      expect(knight.square).to eq square
    end
  end

  describe "#player" do 
    it "can read the player" do 
      knight = Knight.new(:square => square, 
                          :player => player,
                          :color  => player.color)

      expect(knight.player).to eq player
    end
  end

  describe "#points" do 
    it "can read points" do 
      knight = Knight.new(:square => square,
                          :player => player,
                          :color  => player.color)

      expect(knight.points).to eq 3
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

        knight = Knight.new(:square => square, 
                            :player => player,
                            :color  => player.color)

        #knight's starting position for this example
        square.value = knight 

        legal_moves = [grid[2][1], grid[1][2], grid[1][4], grid[2][5],
                       grid[4][5], grid[5][4], grid[5][2], grid[4][1]]

        #gathers all legal moves for the knight instance(stores result in @moves)
        knight.find_moves

        expect(knight.moves).to match_array(legal_moves)
      end
    end

    context "when both white and black pieces are in the directions" do 
      it "returns legal squares" do 
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

        grid[1][2].value = Piece.new(:square => grid[1][2],
                                     :player => other_player,
                                     :color  => other_player.color)
        grid[1][4].value = Piece.new(:square => grid[1][4],
                                     :player => player,
                                     :color  => player.color)
        grid[4][5].value = Piece.new(:square => grid[4][5],
                                     :player => other_player,
                                     :color  => other_player.color)
        grid[4][1].value = Piece.new(:square => grid[4][1],
                                     :player => player,
                                     :color  => player.color)

        knight = Knight.new(:square => square, 
                            :player => player,
                            :color  => player.color)

        #knights's starting position for this example
        square.value = knight 

        legal_moves = [grid[1][2], grid[4][5], grid[2][1], grid[2][5], 
                       grid[5][4], grid[5][2]]
      
        #gathers all legal moves for the knight instance(stores result in @moves)
        knight.find_moves

        expect(knight.moves).to match_array(legal_moves)  
      end
    end
  end
end