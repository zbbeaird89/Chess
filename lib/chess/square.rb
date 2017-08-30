class Square
	attr_accessor :value, :attacked
  alias_method  :attacked?, :attacked

	def initialize(input = "_")
		@value     = input
    @attacked = false
	end
end