class Piece
	attr_reader :grid
	attr_accessor :square

	def initialize(input)
		@grid = input.fetch(:grid)
		@current_square = input.fetch(:square)
	end
end