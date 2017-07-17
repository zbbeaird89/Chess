class Board
  attr_reader :grid

  def initialize
   @grid = default_grid
  end

  private

    def default_grid
      Array.new(8) { Array.new(8) { Square.new } }
    end
end