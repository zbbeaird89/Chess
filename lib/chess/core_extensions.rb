class Array
  def coordinates(object)
    c = nil
    self.each_index do |y|
      x = self[y].index(object)
      c = [y, x] if x
    end
    return c
  end

  def has_king?(curr_king)
    self.any? do |piece|
      if piece.is_a?(King) && piece != curr_king
        return true
      else
        return false
      end
    end
  end
end
