class Piece
	attr_reader :grid, :player
	attr_accessor :square

	def initialize(input)
		@grid   = input.fetch(:grid)
		@square = input.fetch(:square)
    @player = input.fetch(:player)
	end
end