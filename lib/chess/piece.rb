class Piece
	attr_reader :grid
	attr_accessor :current_square

	def initialize(input)
		@grid = input.fetch(:grid)
	end
end