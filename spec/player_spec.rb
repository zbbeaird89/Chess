require "spec_helper"

describe Player do 
  describe "#initialize" do 
    it "is required to give a name" do 
      expect { Player.new }.to raise_error(ArgumentError)
    end
  end

  describe "#name" do 
    it "reads the name" do 
      player = Player.new("Zach")
      expect(player.name).to eq "Zach"
    end
  end
end