require "spec_helper"

describe Piece do 
	describe "#initialize" do 
		it "accepts a grid" do 
			grid = [["_", "_", "_"],
							["_", "_", "_"],
							["_", "_", "_"]]
			expect { Piece.new(:grid => grid) }.to_not raise_error
		end
	end

	describe "#grid" do 
		it "can read the grid" do 
			grid = [["_", "_", "_"],
							["_", "_", "_"],
							["_", "_", "_"]]
			piece = Piece.new(:grid => grid)
			expect(piece.grid).to eq grid
		end
	end
end