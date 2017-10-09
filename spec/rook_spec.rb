require "spec_helper"
require "pry"

describe Rook do
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
        expect { Rook.new(:square => square,
                          :player => player,
                          :color  => player.color) }.to_not raise_error
      end
    end

    context "when given wrong number of arguments" do
      it "raises 'KeyError'" do
        expect { Rook.new(:player => player) }.to raise_error(KeyError)
      end
    end
  end

  describe "#grid" do
    it "can read the grid" do
      grid = [["", "", ""],
              ["", "", ""],
              ["", "", ""]]

      Piece.link_to_grid(grid)

      rook = Rook.new(:square => square,
                      :player => player,
                      :color  => player.color)

      expect(rook.grid).to eq grid
    end
  end

  describe "#square" do
    it "can read the square" do
      rook = Rook.new(:square => square,
                      :player => player,
                      :color  => player.color)

      expect(rook.square).to eq square
    end
  end

  describe "#player" do
    it "can read the player" do
      rook = Rook.new(:square => square,
                      :player => player,
                      :color  => player.color)

      expect(rook.player).to eq player
    end
  end

  describe "#points" do
    it "can read points" do
      rook = Rook.new(:square => square,
                      :player => player,
                      :color  => player.color)

      expect(rook.points).to eq 5
    end
  end

  describe "#moves" do
    context "when all directions contain only empty squares" do
      it "contains legal squares" do
        #Has all pieces link to the grid
        Piece.link_to_grid(grid)

        rook = Rook.new(:square => square,
                        :player => player,
                        :color  => player.color)

        #Rook's starting position for this example
        square.value = rook

        legal_moves = [grid[2][3], grid[1][3], grid[0][3], grid[4][3], grid[5][3],
                       grid[6][3], grid[7][3], grid[3][4], grid[3][5], grid[3][6],
                       grid[3][7], grid[3][2], grid[3][1], grid[3][0]]

        #gathers all legal moves for the rook instance(stores result in @moves)
        rook.find_moves

        expect(rook.moves).to match_array(legal_moves)
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

        rook = Rook.new(:square => square,
                        :player => player,
                        :color  => player.color)

        square.value = rook

        legal_moves = [grid[0][3], grid[1][3], grid[2][3], grid[3][2], grid[3][4],
                       grid[3][5]]

        rook.find_moves

        expect(rook.moves).to match_array(legal_moves)
      end
    end

    context "when the rook is attacking a square" do
      it "the square is being attacked by the rook" do
        Piece.link_to_grid(grid)

        rook = Rook.new(:square => square,
                        :player => player,
                        :color  => player.color)

        square.value = rook

        rook.find_moves

        threatened_sq = grid[3][2]

        expect(threatened_sq.attacked_by).to include rook
      end
    end
  end

  describe "#move" do
    context "when the rook moves and it no longer is attacking a square" do
      it "the square is no longer attacked by the rook" do
        Piece.link_to_grid(grid)

        rook = Rook.new(:square => square,
                        :player => player,
                        :color  => player.color)

        square.value = rook

        rook.find_moves

        rook.move(grid[2][3])

        rook.find_moves

        once_attacked_sq = grid[3][2]

        expect(once_attacked_sq.attacked_by).not_to include rook
      end
    end

    context "when the rook is protecting the knight" do
      it "the knight is protected by the rook" do
        Piece.link_to_grid(grid)

        rook = Rook.new(:square => square,
                        :player => player,
                        :color  => player.color)

        square.value = rook

        grid[7][3].value = Knight.new(:square => grid[7][3],
                                      :player => player,
                                      :color  => player.color)

        knight = grid[7][3].value

        rook.find_moves

        expect(knight.protected?).to be true
        expect(knight.protected_by).to include rook
        expect(rook.protecting).to include knight
      end
    end

    context "when the rook is protecting the knight and then the rook moves" do
      it "the rook is no longer protecting the knight" do
        Piece.link_to_grid(grid)

        rook = Rook.new(:square => square,
                        :player => player,
                        :color  => player.color)

        square.value = rook

        grid[7][3].value = Knight.new(:square => grid[7][3],
                                      :player => player,
                                      :color  => player.color)

        knight = grid[7][3].value

        rook.find_moves

        rook.move(grid[3][2])

        rook.find_moves

        expect(knight.protected_by).not_to include rook
        expect(knight.protected?).to be false
        expect(rook.protecting).to be_empty
      end
    end
  end
end
