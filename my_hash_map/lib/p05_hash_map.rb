require "byebug"
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    @count += 1 unless self.include?(key)
    bucket(key).set(key, val)
    resize! if @count == @store.length
  end

  def get(key)
    # debugger if key == :first
    bucket(key).get(key)
  end

  def delete(key)
    if self.include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each
    @store.each { |list|
      list.each { |node| 
        yield(node.key, node.val)
      } unless list.empty?
      # yield( node.key, node.val ) unless node.empty?
    }
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
    @store = Array.new(@store.length * 2) { LinkedList.new }
    @count = 0
    old_store.each { |list| 
      list.each { |node| self.set(node.key, node.val) }
    }
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
