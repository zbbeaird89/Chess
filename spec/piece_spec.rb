require "spec_helper"

describe Piece do 
	let(:square) { Square.new }
  let(:player) { double("player") }
	let(:mock_grid) { [["_", "_", "_"],
										 ["_", "_", "_"],
										 ["_", "_", "_"]] }
  let(:piece) { Piece.new(:grid   => mock_grid, 
                          :square => square,
                          :player => player) }

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
			expect(piece.grid).to eq mock_grid
		end
	end

	describe "#current_square" do 
		it "can be updated" do 
			piece.square = Square.new
			expect(piece.square.value).to eq "_"
		end
	end

  describe "#move" do 
    context "when given a Square object" do 
      it "sets Square's value to Piece" do 
        new_square  = Square.new
        curr_piece  = Piece.new(:grid => mock_grid, 
                                :square => square,
                                :player => player)
        curr_piece.move(new_square)
        expect(new_square.value).to eq curr_piece
      end

      it "sets Piece's square to Square" do 
        new_square   = Square.new
        square.value = Piece.new(:grid => mock_grid, 
                                 :square => square,
                                 :player => player)
        curr_piece   = square.value
        curr_piece.move(new_square)
        expect(curr_piece.square).to eq new_square
      end

      it "sets Piece's original square value to '_'" do 
        new_square   = Square.new
        square.value = Piece.new(:grid => mock_grid, 
                                 :square => square,
                                 :player => player)
        curr_piece   = square.value
        curr_piece.move(new_square)
        expect(square.value).to eq "_"
      end
    end
  end
end