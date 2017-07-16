require "spec_helper"

describe Piece do 
	let(:mock_grid) { [["_", "_", "_"],
										 ["_", "_", "_"],
										 ["_", "_", "_"]] }

	describe "#initialize" do 
		it "accepts a grid" do 
			expect { Piece.new(:grid => mock_grid) }.to_not raise_error
		end

		it "a piece's current square by default is nil" do 
			piece = Piece.new(:grid => mock_grid)
			expect(piece.current_square).to eq nil
		end
	end

	describe "#grid" do 
		it "can read the grid" do 
			piece = Piece.new(:grid => mock_grid)
			expect(piece.grid).to eq mock_grid
		end
	end
end