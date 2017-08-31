require "spec_helper"

describe Square do 
	describe "#initialize" do 
		context "when no argument is passed" do 
			it "by default sets value = '_'" do 
				square = Square.new
				expect(square.value).to eq "_"
			end
		end

		context "when given an object as an argument" do 
			it "doesn't raise exception" do
				piece = double("piece")
				expect { Square.new(piece) }.to_not raise_error
			end 
		end
	end

	describe "#value" do 
		it "can be updated" do 
			piece = double("piece")
			square = Square.new
			square.value = piece
			expect(square.value).to eq piece
		end
	end

  describe "#attacked?" do 
    it "can be updated and read" do 
      square = Square.new
      square.attacked = true
      expect(square.attacked?).to eq true
    end
  end

  describe "#attacked_by" do 
    it "returns the piece that is attacking the square" do 
      square = Square.new

      rook = Rook.new(:square => square,
                      :player => Player.new("Zach", :white),
                      :color  => :white)

      square.attacked_by << rook

      expect(square.attacked_by).to include rook
    end
  end
end