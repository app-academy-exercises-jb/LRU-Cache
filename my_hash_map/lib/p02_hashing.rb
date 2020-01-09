
class Integer
  # Integer#hash already implemented for you
end

class Array

  def to_i
    case self.length 
    when 0
      return 0
    when 1
      return self[0].to_i
    else
      self.inject do |memo, ele|
        memo.to_i ^ ele.to_i
      end
    end  
  end

  def hash
    return -886114581382812871 if self.empty?
    self.inject do |memo,ele|
      memo.to_i ^ ele.to_i.hash
    end
  end
end

class String
  def to_i
    self.unpack('U*')[0]
  end

  def hash
    self.each_char.map do |char|
      char.to_i
    end.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    # self.to_a.sort.hash
    self.to_a.sort.map(&:hash).hash
  end
end

class Symbol
  def to_i
    self.to_s.to_i
  end
end