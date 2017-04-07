require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    bin = bucket(key)
    if bin.include?(key)
      bin.update(key, val)
    else
      bin.append(key, val)
      @count += 1
      resize! if @count >= num_buckets
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bin = bucket(key)
    deleted = bin.remove(key)
    @count -= 1 if deleted
  end

  def each &prc
    @store.each {|bin| bin.each { |link| prc.call(link.key, link.val) } }
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(2 * num_buckets) { LinkedList.new }
    @count = 0
    old_store.each { |bin| bin.each {|link| set(link.key, link.val) } }
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
