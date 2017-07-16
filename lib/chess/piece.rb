class Piece
	attr_reader :grid
	attr_accessor :current_square

	def initialize(input)
		@grid = input.fetch(:grid)
		@current_square = input.fetch(:current_square)
	end
end