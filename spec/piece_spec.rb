require "spec_helper"

describe Piece do 
	let(:square) { Square.new }
  let(:player) { Player.new("Zach") }
  let(:piece) { Piece.new(:square => square, :player => player) }
 
  let(:mock_grid) { [["_", "_", "_"],
                     ["_", "_", "_"],
                     ["_", "_", "_"]] }

	describe "#initialize" do 
		context "when given correct arguments" do 
			it "doesn't raise an exception" do 
				expect { Piece.new(:square => square, :player => player) }.to_not raise_error
			end
		end
	end

	describe ".grid" do 
		it "can read the grid" do  
      Piece.link_to_grid(mock_grid)
			expect(piece.grid).to eq mock_grid
		end
	end

  describe "#square" do 
    it "can be updated" do 
      piece.square = Square.new
      expect(piece.square.value).to eq "_"
    end
  end

  describe "#player" do 
    it "can read the player" do 
      expect(piece.player).to eq player
    end 
  end

  describe "#points" do 
    it "can read the points" do 
      expect(piece.points).to eq 1
    end
  end

  describe "#move" do 
    context "when given a Square object" do 
      it "sets Square's value to Piece" do 
        new_square  = Square.new
        curr_piece  = Piece.new(:square => square, :player => player)
        curr_piece.move(new_square)
        expect(new_square.value).to eq curr_piece
      end

      it "sets Piece's square to Square" do 
        new_square   = Square.new
        square.value = Piece.new(:square => square, :player => player)
        curr_piece   = square.value
        curr_piece.move(new_square)
        expect(curr_piece.square).to eq new_square
      end

      it "sets Piece's original square value to '_'" do 
        new_square   = Square.new
        square.value = Piece.new(:square => square, :player => player)
        curr_piece   = square.value
        curr_piece.move(new_square)
        expect(square.value).to eq "_"
      end

      context "when moving to square that's occupied" do 
        it "applies that piece's points to player's points" do 
          other_player = Player.new("Lauren")

          occupied_square = Square.new
          occupied_square.value = Piece.new(:square => occupied_square, :player => other_player)

          square.value = Piece.new(:square => square, :player => player)

          curr_piece = square.value

          curr_piece.move(occupied_square)

          expect(curr_piece.player.points).to eq 1
        end
      end
    end
  end
end