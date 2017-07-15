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
			it "it passes" do
				piece = double("piece")
				expect { Square.new(piece) }.to_not raise_error
			end 
		end
	end
end