class Array 
  def coordinates(object)
    c = nil
    self.each_index do |y|
      x = self[y].index(object)
      c = [y, x] if x
    end
    return c
  end
end