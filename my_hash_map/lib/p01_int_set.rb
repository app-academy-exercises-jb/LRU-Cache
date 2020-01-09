class MaxIntSet
  attr_reader :store

  def initialize(max)
    @max = max
    @store = Array.new(@max+1, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private
  def is_valid?(num)
    num <= @max && num >= 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless self.include?(num)
  end

  def remove(num)
    include?(num) ?
      self[num].delete(num) :
      nil
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @buckets] 
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == @buckets 
    unless self.include?(num)
      self[num] << num 
      @count += 1
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    raise "must be number" unless num.is_a?(Integer)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @buckets] 
    # @store[20 % 40]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @buckets *= 2
    @store = Array.new(@buckets) { Array.new }
    @count = 0
    old_store.flatten.each { |ele| self.insert(ele) }
  end
end
