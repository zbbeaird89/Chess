require "spec_helper"

describe Pawn do
  let(:square)       { Square.new }
  let(:player)       { Player.new("Zach", :white) }
  let(:other_player) { Player.new("Lauren", :black) }
  let(:grid)         { [[Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new],
                        [Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new, Square.new]] }

  describe "#initialize" do
    context "when given correct number of arguments" do
      it "doesn't raise exception" do
        expect { Pawn.new(:square => square,
                          :player => player,
                          :color  => player.color) }.to_not raise_error
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
      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square,
                      :player => player,
                      :color  => player.color)

      expect(pawn.grid).to eq grid
    end
  end

  describe "#square" do
    it "can read the square" do
      pawn = Pawn.new(:square => square,
                      :player => player,
                      :color  => player.color)
      expect(pawn.square).to eq square
    end
  end

  describe "#player" do
    it "can read the player" do
      pawn = Pawn.new(:square => square,
                      :player => player,
                      :color  => player.color)
      expect(pawn.player).to eq player
    end
  end

  describe "#points" do
    it "can read points" do
      pawn = Pawn.new(:square => square,
                      :player => player,
                      :color  => player.color)
      expect(pawn.points).to eq 1
    end
  end

  describe "#moves" do
    it "contains legal moves for white player" do
      #Has all pieces link to the grid
      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square,
                      :player => player,
                      :color  => player.color)

      #Pawn's starting position for this example
      grid[6][4] = square

      legal_moves = [grid[5][4], grid[4][4]]

      #gathers all legal moves for the pawn instance(stores result in @moves)
      pawn.find_moves

      expect(pawn.moves).to match_array(legal_moves)
    end

    it "contains legal moves for black player" do
      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square,
                      :player => other_player,
                      :color  => other_player.color)

      grid[1][4] = square

      legal_moves = [grid[2][4], grid[3][4]]

      pawn.find_moves

      expect(pawn.moves).to match_array(legal_moves)
    end

    it "recognizes enemies at diagonals for white player" do
      #Sets left diagonal to contain enemy piece
      grid[5][3].value = Piece.new(:square => grid[5][3],
                                   :player => other_player,
                                   :color  => other_player.color)
      grid[5][5].value = Piece.new(:square => grid[5][5],
                                   :player => other_player,
                                   :color  => other_player.color)

      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square,
                      :player => player,
                      :color  => player.color)

      grid[6][4] = square
      square.value = pawn

      legal_moves = [grid[5][4], grid[4][4], grid[5][3], grid[5][5]]

      pawn.find_moves

      expect(pawn.moves).to match_array(legal_moves)
    end

    it "recognizes enemies at diagonals for black player" do
      #Sets left diagonal to contain enemy piece
      grid[2][3].value = Piece.new(:square => grid[2][3],
                                   :player => player,
                                   :color  => player.color)
      grid[2][5].value = Piece.new(:square => grid[2][5],
                                   :player => player,
                                   :color  => player.color)
      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square,
                      :player => other_player,
                      :color  => other_player.color)

      grid[1][4] = square

      legal_moves = [grid[2][3], grid[2][5], grid[2][4], grid[3][4]]

      pawn.find_moves

      expect(pawn.moves).to match_array(legal_moves)
    end
  end

  describe "#move" do
    context "when given illegal square" do
      it "returns false" do
        Piece.link_to_grid(grid)

        pawn = Pawn.new(:square => square,
                        :player => player,
                        :color  => player.color)

        grid[6][4] = square

        pawn.find_moves

        expect(pawn.move(grid[5][3])).to eq false
      end
    end

    it "moves piece to a legal square" do
      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square,
                      :player => player,
                      :color  => player.color)

      grid[6][4] = square

      pawn.find_moves

      pawn.move(grid[5][4])

      expect(grid[5][4].value).to eq pawn
    end

    it "piece's square changes as expected" do

      Piece.link_to_grid(grid)

      pawn = Pawn.new(:square => square,
                      :player => player,
                      :color  => player.color)

      grid[6][4] = square

      pawn.find_moves

      pawn.move(grid[5][4])

      expect(pawn.square).to eq grid[5][4]
    end
  end
end
