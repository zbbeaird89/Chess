require "spec_helper"

describe Square do 
	describe "#initialize" do 
		context "when no argument is passed" do 
			it "by default sets value = '_'" do 
				square = Square.new
				expect(square.value).to eq "_"
			end
		end
	end
end