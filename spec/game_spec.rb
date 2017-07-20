require "spec_helper"

describe Game do 
  let(:player1) { Player.new("Zach") }
  let(:player2) { Player.new("Lauren") }

  describe "#initialize" do 
    context "when given players" do 
      it "doesn't raise error" do 
        players = [player1, player2]
        expect { Game.new(:players => players) }.to_not raise_error
      end
    end

    context "when not given any arguments" do 
      it "raises ArgumentError" do 
        expect { Game.new }.to raise_error(ArgumentError)
      end
    end
  end
end