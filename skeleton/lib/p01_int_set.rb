class MaxIntSet
  def initialize(max)
    @store = Array.new(max)
  end

  def insert(num)
    helper(num) { |num| @store[num] = true }
  end

  def remove(num)
    helper(num) { |num| @store[num] = false }
  end

  def include?(num)
    helper(num) { |num| @store[num] }
  end

  private
  def helper(num, &prc)
    if num.between?(0, @store.length-1)
      prc.call(num)
    else
      raise "Out of bounds"
    end
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].each { |el| return true if num == el }
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      self[num] << num
      @count += 1
      resize! if @count >= num_buckets
    end
  end

  #
  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end
  #
  def include?(num)
    self[num].each { |el| return true if num == el }
    false
  end

  private
  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) {Array.new}
    old_store.flatten.each {|el| insert(el) }
  end


end
