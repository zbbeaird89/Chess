require "spec_helper"

describe Player do 
  describe "#initialize" do 
    it "is required to give a name" do 
      expect { Player.new }.to raise_error(ArgumentError)
    end
  end

  describe "#name" do 
    it "reads the name" do 
      player = Player.new("Zach", :white)
      expect(player.name).to eq "Zach"
    end
  end

  describe "#color" do 
    it "reads the color" do 
      player = Player.new("Zach", :white)
      expect(player.color).to eq :white
    end
  end

  describe "#points" do 
    it "can be updated" do 
      player = Player.new("Zach", :white)
      player.points += 3
      expect(player.points).to eq 3
    end
  end
end