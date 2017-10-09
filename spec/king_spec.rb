require "spec_helper"

describe King do
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
        expect { King.new(:square => square,
                          :player => player,
                          :color  => player.color) }.to_not raise_error
      end
    end

    context "when given wrong number of arguments" do
      it "raises 'KeyError'" do
        expect { King.new(:player => player) }.to raise_error(KeyError)
      end
    end
  end

  describe "#grid" do
    it "can read the grid" do
      grid = [["", "", ""],
              ["", "", ""],
              ["", "", ""]]

      Piece.link_to_grid(grid)

      king = King.new(:square => square,
                      :player => player,
                      :color  => player.color)

      expect(king.grid).to eq grid
    end
  end

  describe "#square" do
    it "can read the square" do
      king = King.new(:square => square,
                      :player => player,
                      :color  => player.color)

      expect(king.square).to eq square
    end
  end

  describe "#player" do
    it "can read the player" do
      king = King.new(:square => square,
                      :player => player,
                      :color  => player.color)

      expect(king.player).to eq player
    end
  end

  describe "#points" do
    it "can read points" do
      king = King.new(:square => square,
                      :player => player,
                      :color  => player.color)

      expect(king.points).to eq 1
    end
  end

  describe "#check?" do
    context "when king is in check" do
      it "returns true" do
        #Has all pieces link to grid
        Piece.link_to_grid(grid)

        king = King.new(:square => square,
                        :player => player,
                        :color  => player.color)

        square.value = king

        grid[0][3].value = Rook.new(:square => grid[0][3],
                                    :player => other_player,
                                    :color  => other_player.color)
        rook = grid[0][3].value

        rook.find_moves

        expect(king.check?).to eq true
      end
    end
  end

  describe "#moves" do
    context "when all directions contain only empty squares and they aren't attacked" do
      it "contains correct legal squares" do
        Piece.link_to_grid(grid)

        king = King.new(:square => square,
                        :player => player,
                        :color  => player.color)

        #king's starting position for this example
        square.value = king

        legal_moves = [grid[2][2], grid[2][3], grid[2][4], grid[3][4],
                       grid[4][4], grid[4][3], grid[4][2], grid[3][2]]

        #gathers all legal moves for the king instance(stores result in @moves)
        king.find_moves

        expect(king.moves).to match_array(legal_moves)
      end
    end

    context "when both white and black pieces are in the directions" do
      it "returns correct legal squares" do
        #Has all pieces link to the grid
        Piece.link_to_grid(grid)

        grid[2][3].value = Piece.new(:square => grid[2][3],
                                     :player => other_player,
                                     :color  => other_player.color)
        grid[4][3].value = Piece.new(:square => grid[4][3],
                                     :player => player,
                                     :color  => player.color)
        grid[3][2].value = Piece.new(:square => grid[3][2],
                                     :player => other_player,
                                     :color  => other_player.color)
        grid[3][4].value = Piece.new(:square => grid[3][4],
                                     :player => player,
                                     :color  => player.color)
        grid[2][2].value = Piece.new(:square => grid[2][2],
                                     :player => player,
                                     :color  => player.color)
        grid[4][2].value = Piece.new(:square => grid[4][2],
                                     :player => other_player,
                                     :color  => other_player.color)
        grid[4][4].value = Piece.new(:square => grid[4][4],
                                     :player => player,
                                     :color  => player.color)
        grid[2][4].value = Piece.new(:square => grid[2][4],
                                     :player => other_player,
                                     :color  => other_player.color)

        king = King.new(:square => square,
                        :player => player,
                        :color  => player.color)

        #kings's starting position for this example
        square.value = king

        legal_moves = [grid[3][2], grid[2][3], grid[2][4], grid[4][2]]

        #gathers all legal moves for the king instance(stores result in @moves)
        king.find_moves

        expect(king.moves).to match_array(legal_moves)
      end
    end

    context "when the king is attacking a square" do
      it "the square is being attacked by the king" do
        Piece.link_to_grid(grid)

        king = King.new(:square => square,
                        :player => player,
                        :color  => player.color)

        square.value = king

        king.find_moves

        threatened_sq = grid[4][2]

        expect(threatened_sq.attacked_by).to include king
      end
    end
  end

  describe "#move" do
    context "when the king moves and it no longer is attacking a square" do
      it "the square is no longer attacked by the king" do
        Piece.link_to_grid(grid)

        king = King.new(:square => square,
                        :player => player,
                        :color  => player.color)

        square.value = king

        king.find_moves

        king.move(grid[4][4])

        king.find_moves

        once_attacked_sq = grid[4][2]

        expect(once_attacked_sq.attacked_by).not_to include king
      end
    end

    context "when the king is protecting the knight" do
      it "the knight is protected by the king" do
        Piece.link_to_grid(grid)

        king = King.new(:square => square,
                        :player => player,
                        :color  => player.color)

        square.value = king

        grid[2][2].value = Knight.new(:square => grid[2][2],
                                      :player => player,
                                      :color  => player.color)

        knight = grid[2][2].value

        king.find_moves

        expect(knight.protected?).to be true
        expect(knight.protected_by).to include king
        expect(king.protecting).to include knight
      end
    end

    context "when the king is protecting the knight and then the king moves" do
      it "the king is no longer protecting the knight" do
        Piece.link_to_grid(grid)

        king = King.new(:square => square,
                        :player => player,
                        :color  => player.color)

        square.value = king

        grid[2][2].value = Knight.new(:square => grid[2][2],
                                      :player => player,
                                      :color  => player.color)

        knight = grid[2][2].value

        king.find_moves

        king.move(grid[4][2])

        king.find_moves

        expect(knight.protected_by).not_to include king
        expect(knight.protected?).to be false
        expect(king.protecting).to be_empty
      end
    end
  end
end
