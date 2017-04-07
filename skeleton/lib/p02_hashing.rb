class Fixnum
  # Fixnum#hash already implemented for you
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Array
  def hash
    self.each.with_index.reduce(0) do |hash, (el, i)|
      if(el.is_a?(Array))
        hash ^ el.hash * i
      else
        hash ^ el * i
      end
    end.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    flattened_hash = self.to_a.flatten
    stringified_hash = flattened_hash.map(&:to_s)
    hashed_strings = stringified_hash.map(&:hash)
    hashed_strings.sort.hash
  end
end
