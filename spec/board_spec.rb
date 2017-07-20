require "spec_helper"
require "pry"

describe Board do 
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
end