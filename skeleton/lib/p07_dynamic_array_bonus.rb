class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @first_index = 0
  end

  def [](i)
    return nil if i.between?(-capacity, )
    @store[get_index(i)]
  end

  def []=(i, val)
    @store[get_index(i)] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    capacity.times do |i|
      return true if @store[i] == val
    end
    false
  end

  def push(val)
    # TODO: Resize later
    @store[get_index(count)] = val
    @count += 1
  end

  def unshift(val)
    @first_index = get_index(-1)
    @store[get_index(0)] = val
    @count += 1
  end

  def pop
    @count -= 1 if @count != 0
    popped = @store[get_index(count)]
    @store[get_index(count)] = nil
    popped
  end

  def shift
    if @count == 0
      nil
    else
      @count -= 1
      shifted = first
      @store[@first_index] = nil
      @first_index = (@first_index + 1) % capacity
      shifted
    end
  end

  def first
    @store[@first_index]
  end

  def last
    @store[get_index(@count - 1)]
  end

  def each
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
  end

  def get_index(num)
    (num + @first_index) % capacity
  end
end
