require "spec_helper"

describe Queen do 
  let(:square)       { Square.new }
  let(:player)       { Player.new("Zach", :white) }
  let(:other_player) { Player.new("Lauren", :black) }
  let(:grid)         { [[Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, square, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new]] }

  describe "#initialize" do 
    context "when given correct number of arguments" do 
      it "doesn't raise exception" do 
        expect { Queen.new(:square => square,
                           :player => player,
                           :color  => player.color) }.to_not raise_error
      end
    end

    context "when given wrong number of arguments" do 
      it "raises 'KeyError'" do 
        expect { Queen.new(:player => player) }.to raise_error(KeyError)
      end
    end
  end

  describe "#grid" do 
    it "can read the grid" do 
      grid = [["", "", ""],
              ["", "", ""],
              ["", "", ""]]

      Piece.link_to_grid(grid)

      queen = Queen.new(:square => square, 
                        :player => player,
                        :color  => player.color)

      expect(queen.grid).to eq grid
    end
  end

  describe "#square" do 
    it "can read the square" do 
      queen = Queen.new(:square => square, 
                        :player => player,
                        :color  => player.color)

      expect(queen.square).to eq square
    end
  end

  describe "#player" do 
    it "can read the player" do 
      queen = Queen.new(:square => square, 
                        :player => player,
                        :color  => player.color)

      expect(queen.player).to eq player
    end
  end

  describe "#points" do 
    it "can read points" do 
      queen = Queen.new(:square => square, 
                        :player => player,
                        :color  => player.color)

      expect(queen.points).to eq 9
    end
  end

  describe "#moves" do 
    context "when all directions contain only empty squares" do 
      it "contains legal squares" do 
        #Has all pieces link to the grid
        Piece.link_to_grid(grid)

        queen = Queen.new(:square => square, 
                          :player => player,
                          :color  => player.color)

        #queen's starting position for this example
        square.value = queen 

        legal_moves = [grid[3][2], grid[3][1], grid[3][0], grid[2][2], grid[1][1], grid[0][0],
                       grid[2][3], grid[1][3], grid[0][3], grid[2][4], grid[1][5], grid[0][6],
                       grid[3][4], grid[3][5], grid[3][6], grid[3][7], grid[4][4], grid[5][5],
                       grid[6][6], grid[7][7], grid[4][3], grid[5][3], grid[6][3], grid[7][3],
                       grid[4][2], grid[5][1], grid[6][0]]

        #gathers all legal moves for the queen instance(stores result in @moves)
        queen.find_moves

        expect(queen.moves).to match_array(legal_moves)
      end
    end

    context "when both white and black pieces are in the directions" do 
      it "returns legal squares" do 
        Piece.link_to_grid(grid)

        grid[0][3].value = Piece.new(:square => grid[0][3],
                                     :player => other_player,
                                     :color  => other_player.color)
        grid[4][3].value = Piece.new(:square => grid[4][3],
                                     :player => player,
                                     :color  => player.color)
        grid[3][2].value = Piece.new(:square => grid[3][2],
                                     :player => other_player,
                                     :color  => other_player.color)
        grid[3][6].value = Piece.new(:square => grid[3][6],
                                     :player => player,
                                     :color  => player.color)
        grid[0][0].value = Piece.new(:square => grid[0][0],
                                     :player => player,
                                     :color  => player.color)
        grid[1][5].value = Piece.new(:square => grid[1][5],
                                     :player => other_player,
                                     :color  => other_player.color)
        grid[6][6].value = Piece.new(:square => grid[6][6],
                                     :player => player,
                                     :color  => player.color)
        grid[6][0].value = Piece.new(:square => grid[3][6],
                                     :player => other_player,
                                     :color  => other_player.color)

        queen = Queen.new(:square => square, 
                          :player => player,
                          :color  => player.color)

        square.value = queen 

        legal_moves = [grid[3][2], grid[0][3], grid[1][3], grid[2][3], grid[3][4],
                       grid[3][5], grid[1][1], grid[2][2], grid[1][5], grid[2][4],
                       grid[5][5], grid[4][4], grid[6][0], grid[5][1], grid[4][2]]
      
        queen.find_moves

        expect(queen.moves).to match_array(legal_moves)  
      end
    end

    context "when the queen is attacking a square" do 
      it "the square is being attacked by the queen" do
        Piece.link_to_grid(grid)

        queen = Queen.new(:square => square, 
                          :player => player,
                          :color  => player.color)

        square.value = queen 
        
        queen.find_moves

        threatened_sq = grid[3][2]

        expect(threatened_sq.attacked_by).to include queen
      end
    end
  end

  describe "#move" do 
    context "when the queen moves and it no longer is attacking a square" do 
      it "the square is no longer attacked by the queen" do 
        Piece.link_to_grid(grid)

        queen = Queen.new(:square => square, 
                          :player => player,
                          :color  => player.color)

        square.value = queen 
        
        queen.find_moves

        queen.move(grid[2][3])

        queen.find_moves

        once_attacked_sq = grid[3][0]

        expect(once_attacked_sq.attacked_by).not_to include queen        
      end
    end

    context "when the queen is protecting the knight" do 
      it "the knight is protected by the queen" do 
        Piece.link_to_grid(grid)

        queen = Queen.new(:square => square, 
                          :player => player,
                          :color  => player.color)

        square.value = queen 

        grid[7][3].value = Knight.new(:square => grid[7][3],
                                      :player => player,
                                      :color  => player.color)

        knight = grid[7][3].value
        
        queen.find_moves

        expect(knight.protected?).to be true
        expect(knight.protected_by).to include queen
        expect(queen.protecting).to include knight
      end
    end

    context "when the queen is protecting the knight and then the queen moves" do 
      it "the queen is no longer protecting the knight" do 
        Piece.link_to_grid(grid)

        queen = Queen.new(:square => square, 
                          :player => player,
                          :color  => player.color)

        square.value = queen 

        grid[7][3].value = Knight.new(:square => grid[7][3],
                                      :player => player,
                                      :color  => player.color)

        knight = grid[7][3].value
        
        queen.find_moves

        queen.move(grid[3][2])

        queen.find_moves

        expect(knight.protected_by).not_to include queen
        expect(knight.protected?).to be false
        expect(queen.protecting).to be_empty 
      end
    end
  end
end