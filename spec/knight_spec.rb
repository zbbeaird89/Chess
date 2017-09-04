require "spec_helper"
require "pry"

describe Knight do 
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

        square.value = knight 

        legal_moves = [grid[1][2], grid[4][5], grid[2][1], grid[2][5], 
                       grid[5][4], grid[5][2]]
      
        knight.find_moves

        expect(knight.moves).to match_array(legal_moves)  
      end
    end

    context "when the knight is attacking a square" do 
      it "the square is being attacked by the knight" do
        Piece.link_to_grid(grid)

        knight = Knight.new(:square => square, 
                            :player => player,
                            :color  => player.color)

        square.value = knight 
        
        knight.find_moves

        threatened_sq = grid[1][2]

        expect(threatened_sq.attacked_by).to include knight
      end
    end
  end

  describe "#move" do 
    context "when the knight moves and it no longer is attacking a square" do 
      it "the square is no longer attacked by the knight" do 
        Piece.link_to_grid(grid)

        knight = Knight.new(:square => square, 
                            :player => player,
                            :color  => player.color)

        square.value = knight 
        
        knight.find_moves

        knight.move(grid[2][3])

        knight.find_moves

        once_attacked_sq = grid[3][0]

        expect(once_attacked_sq.attacked_by).not_to include knight        
      end
    end

    context "when the knight is protecting the queen" do 
      it "the queen is protected by the knight" do 
        Piece.link_to_grid(grid)

        knight = Knight.new(:square => square, 
                            :player => player,
                            :color  => player.color)

        square.value = knight 

        grid[1][2].value = Queen.new(:square => grid[1][2],
                                     :player => player,
                                     :color  => player.color)

        queen = grid[1][2].value
        
        knight.find_moves

        expect(queen.protected?).to be true
        expect(queen.protected_by).to include knight
        expect(knight.protecting).to include queen
      end
    end

    context "when the knight is protecting the queen and then the knight moves" do 
      it "the knight is no longer protecting the queen" do 
        Piece.link_to_grid(grid)

        knight = Knight.new(:square => square, 
                            :player => player,
                            :color  => player.color)

        square.value = knight 

        grid[1][2].value = Queen.new(:square => grid[1][2],
                                     :player => player,
                                     :color  => player.color)

        queen = grid[1][2].value
        
        knight.find_moves

        knight.move(grid[1][4])

        knight.find_moves

        expect(queen.protected_by).not_to include knight
        expect(queen.protected?).to be false
        expect(knight.protecting).to be_empty 
      end
    end
  end
end