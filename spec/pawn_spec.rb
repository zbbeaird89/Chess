require "spec_helper"

describe Pawn do 
  let(:square) { Square.new }
  let(:player) { double("player") }
  let(:mock_grid) { [["_", "_", "_"],
                     ["_", "_", "_"],
                     ["_", "_", "_"]] }
  let(:pawn) { Pawn.new(:grid   => mock_grid, 
                        :square => square,
                        :player => player) }

  describe "#initialize" do 
    context "when given correct number of arguments" do 
      it "doesn't raise exception" do 
        expect { Pawn.new(:grid => mock_grid,
                          :square => square,
                          :player => player) }.to_not raise_error
      end
    end

    context "when given wrong number of arguments" do 
      it "raises 'ArgumentError'" do 
        expect { Pawn.new(:grid => mock_grid,
                          :player => player) }.to raise_error(KeyError)
      end
    end
  end
end