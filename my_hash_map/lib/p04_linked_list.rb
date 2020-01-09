class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def inspect
    {@key => @val}
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @prev.next = @next if @prev
    @next.prev = @prev if @next
  end
end

class LinkedList
  include Enumerable

  
  def initialize
    @head, @tail = nil
  end

  def [](key)
    # each_with_index { |node, j| return node if i == j }
    each { |node| return node if key == node.key }
    nil
  end

  def first
    @head# ? @head.val : nil
  end

  def last
    @tail# ? @tail.val : nil
  end

  def empty?
    @head == nil
  end

  def get(key)
    return nil unless self.include?(key)
    self[key].val
  end

  def include?(key)
    !!self[key]
  end

  def set (key,val)
    if self.include?(key)
      update(key,val)
    else
      append(key,val)
    end
  end
  alias_method :[]=, :set

  def remove(key)
    # need to update @head / @tail if that's the one we removed
    removed = self[key]
    if removed
      removed.remove 

      if removed == @head
        @head = @head.next
      end

      if removed == @tail
        @tail = @tail.prev
      end
    end
  end

  def each
    raise "must pass a block" unless block_given?
    return if @head.nil?

    yield @head 
    # prc.call(@head)
    current_node = @head.next
    until current_node.nil?
      yield current_node
      current_node = current_node.next
    end
  end
  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end

  private
  def append(key, val)
    new_node = Node.new(key, val)
    if @head == nil
      @head = new_node
      @tail = new_node
      # new_node.next = @tail
    else
      old_tail = @tail
      @tail = new_node
      old_tail.next = @tail
      @tail.prev = old_tail
    end
  end

  def update(key, val)
    self[key].val = val
  end
end


# Node
# (key,val)
# @next
# @prev