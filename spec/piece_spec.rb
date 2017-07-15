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
end