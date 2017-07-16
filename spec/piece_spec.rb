require "spec_helper"

describe Piece do 
	let(:mock_grid) { [["_", "_", "_"],
										 ["_", "_", "_"],
										 ["_", "_", "_"]] }

	describe "#initialize" do 
		it "accepts a grid" do 
			expect { Piece.new(:grid => mock_grid) }.to_not raise_error
		end
	end

	describe "#grid" do 
		it "can read the grid" do 
			piece = Piece.new(:grid => mock_grid)
			expect(piece.grid).to eq mock_grid
		end
	end

	describe "#current_square" do 
		it "can be updated" do 
			piece = Piece.new(:grid => mock_grid)
			piece.current_square = Square.new
			expect(piece.current_square.value).to eq "_"
		end
	end
end