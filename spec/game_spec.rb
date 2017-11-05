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

    context "when pieces are assigned to their starting positions" do
      it "White King is in correct position" do
        game = Game.new(:players => players)
        expect(game.board.squares["E1"].value).to be_a King
      end

      it "Black King is in correct position" do
        game = Game.new(:players => players)
        expect(game.board.squares["E8"].value).to be_a King
      end

      it "A White Pawn is in correct position" do
        game = Game.new(:players => players)
        expect(game.board.squares["E2"].value).to be_a Pawn
      end

      it "A Black Pawn is in correct position" do
        game = Game.new(:players => players)
        expect(game.board.squares["E7"].value).to be_a Pawn
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

  describe "#game_over" do
    context "when king is in checkmate" do
=begin
      it "returns true" do
        game = Game.new(:players => players)

        #white king will be in checkmate for this example
        king = game.board.kings.select { |king| king.color == :white  }[0]

        game.board.squares["F2"].value.move(game.board.squares["F3"])
        game.board.squares["E7"].value.move(game.board.squares["E5"])
        game.board.squares["G2"].value.move(game.board.squares["G4"])
        game.board.squares["D8"].value.move(game.board.squares["H4"])

        expect(game.game_over(king)).to be true
      end
=end
      it "returns true" do
        game = Game.new(:players => players)

        #white king will be in checkmate for this example
        king = game.board.kings.select { |king| king.color == :black  }[0]

        game.board.squares["E2"].value.move(game.board.squares["E4"])
        game.board.squares["E7"].value.move(game.board.squares["E5"])
        game.board.squares["F1"].value.move(game.board.squares["C4"])
        game.board.squares["B8"].value.move(game.board.squares["C6"])
        game.board.squares["D1"].value.move(game.board.squares["F3"])
        game.board.squares["D7"].value.move(game.board.squares["D6"])
        game.board.squares["F3"].value.move(game.board.squares["F7"])

        game.current_player = player2
        game.other_player   = player1

        #TODO this doesn't pass in the game

        expect(game.game_over(king)).to be true
      end
    end
  end
end

#f2 f3
#e7 e5
#g2 g4
#d8 h4
