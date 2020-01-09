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
    @next = nil
    @prev = nil
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
    @head
  end

  def last
    @tail
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

  def delete(node)
    raise "#{node} must be a node" unless node.is_a?(Node)
    @head = @head.next if node == @head
    @tail = @tail.prev if node == @tail

    node.remove
    node
  end

  def remove(key)
    removed = self[key]
    delete(removed) if removed
  end

  def each
    raise "must pass a block" unless block_given?
    return if @head.nil?

    yield @head 

    current_node = @head.next
    until current_node.nil?
      yield current_node
      current_node = current_node.next
    end
  end
  
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end

private
  def append(key, val)
    new_node = Node.new(key, val)
    if @head == nil
      @head = @tail = new_node
    else
      old_tail, @tail = @tail, new_node
      old_tail.next, @tail.prev = @tail, old_tail
    end
    new_node
  end
  
  def update(key, val)
    node, node.val = self[key], val
    node
  end
end