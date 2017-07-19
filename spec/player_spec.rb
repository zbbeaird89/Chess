require "spec_helper"

describe Player do 
  describe "#initialize" do 
    it "is required to give a name" do 
      expect { Player.new }.to raise_error(ArgumentError)
    end
  end
end