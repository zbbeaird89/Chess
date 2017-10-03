require "spec_helper"

describe Board do
  let(:player) { Player.new("Zach", :white) }

  describe "#initialize" do
    it "creates a grid with 8 rows by default" do
      board = Board.new
      expect(board.grid.length).to eq 8
    end

    it "creates a grid with 8 columns" do
      board = Board.new
      board.grid.each do |row|
        expect(row.length).to eq 8
      end
    end
  end

  describe "#squares" do
    context "when given a chess notation" do
      it "returns that square" do
        board = Board.new
        square = board.grid[0][0]
        expect(board.squares["A8"]).to eq square
      end
    end
  end

  describe "#track_pieces" do
    it "stores a piece to @pieces" do
      board = Board.new

      rook  = Rook.new(:square => board.squares["A1"],
                       :player => player,
                       :color  => player.color)

      board.squares["A1"].value = rook

      board.track_pieces

      expect(board.pieces).to include(rook)
    end

    it "stores multiple pieces to @pieces" do
      board = Board.new

      rook  = Rook.new(:square => board.squares["A1"],
                       :player => player,
                       :color  => player.color)

      queen = Queen.new(:square => board.squares["D1"],
                        :player => player,
                        :color  => player.color)

      knight = Knight.new(:square => board.squares["G1"],
                          :player => player,
                          :color  => player.color)

      board.squares["A1"].value = rook
      board.squares["D1"].value = queen
      board.squares["G1"].value = knight

      board.track_pieces

      expect(board.pieces).to include(rook, queen, knight)
    end

    it "doesn't store a King in @pieces" do
      board = Board.new

      king  = King.new(:square => board.squares["E1"],
                       :player => player,
                       :color  => player.color)

      board.squares["E1"].value = king

      board.track_pieces

      expect(board.pieces).to be_empty
    end

    it "stores a King in @kings" do
      board = Board.new

      king  = King.new(:square => board.squares["E1"],
                       :player => player,
                       :color  => player.color)

      board.squares["E1"].value = king

      board.track_pieces

      expect(board.kings).to include(king)
    end
  end
end
