class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head, @tail = Link.new, Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each {|link| return link.val if link.key == key}
    nil
  end

  def include?(key)
    self.each {|link| return true if link.key == key}
    false
  end

  def append(key, val)
    second_to_last = @tail.prev
    new_link = Link.new(key, val)
    second_to_last.next = new_link
    @tail.prev = new_link
    new_link.prev = second_to_last
    new_link.next = @tail
  end

  def update(key, val)
    self.each {|link| link.val = val if link.key == key }
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        link.remove
        return true
      end
    end
    false
  end

  def each(&prc)
    current_link = first
    while current_link != @tail
      prc.call(current_link)
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
