require "spec_helper"

describe Array do 
  describe "#coordinates" do 
    context "when called on a nested array" do 
      context "and given an object as an argument" do 
        it "returns the x, y coordinates of the object" do 
          square = Square.new
          array = [["", "", ""], 
                   ["", "", ""], 
                   ["", square, ""]]
          expect(array.coordinates(square)).to eq [2, 1]
        end
      end
    end
  end
end