class Square
	attr_accessor :value, :attacked, :attacked_by
  alias_method  :attacked?, :attacked

	def initialize(input = "_")
		@value       = input
    @attacked    = false
    @attacked_by = []
	end
end