require "spec_helper"

describe Game do 
  let(:player1) { Player.new("Zach", :white) }
  let(:player2) { Player.new("Lauren", :black) }
  let(:players) { [player1, player2] }

  describe "#initialize" do 
    context "when given players" do 
      it "doesn't raise error" do 
        expect { Game.new(:players => players) }.to_not raise_error
      end
    end

    context "when not given any arguments" do 
      it "raises ArgumentError" do 
        expect { Game.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#players" do 
    it "reads player1" do 
      game = Game.new(:players => players)
      expect(game.player1).to eq player1
    end

    it "reads player2" do 
      game = Game.new(:players => players)
      expect(game.player2).to eq player2
    end
  end

  describe "#board" do 
    it "can access the grid" do 
      game = Game.new(:players => players)
      expect { game.board.grid }.to_not raise_error
    end

    it "can access a square" do 
      game = Game.new(:players => players)
      expect(game.board.squares["A3"]).to eq game.board.grid[5][0]
    end
  end
end