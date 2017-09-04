class Square
	attr_accessor :value, :attacked_by

	def initialize(input = "_")
		@value       = input
    @attacked_by = []
	end

  def attacked?
    @attacked_by.empty? ? false : true
  end
end