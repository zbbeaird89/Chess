require "spec_helper"

describe Piece do 
	let(:square) { Square.new }
  let(:player) { double("player") }
	let(:mock_grid) { [["_", "_", "_"],
										 ["_", "_", "_"],
										 ["_", "_", "_"]] }

	describe "#initialize" do 
		context "when given correct arguments" do 
			it "doesn't raise an exception" do 
				expect { Piece.new(:grid => mock_grid, 
                           :square => square,
                           :player => player) }.to_not raise_error
			end
		end
	end

	describe "#grid" do 
		it "can read the grid" do 
			piece = Piece.new(:grid => mock_grid, 
                        :square => square,
                        :player => player)
			expect(piece.grid).to eq mock_grid
		end
	end

	describe "#current_square" do 
		it "can be updated" do 
			piece = Piece.new(:grid => mock_grid, 
                        :square => square,
                        :player => player)
			piece.square = Square.new
			expect(piece.square.value).to eq "_"
		end
	end
end