class Square
	attr_accessor :value, :attacked, :attacked_by
  alias_method  :attacked?, :attacked

	def initialize(input = "_")
		@value       = input
    @attacked_by = []
    @attacked    = @attacked_by.empty? ? false : true
	end
end