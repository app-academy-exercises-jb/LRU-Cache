require "byebug"
require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new(max**2)
    @store = LinkedList.new
    @max, @prc = max, prc
  end

  def count
    @map.count
  end

  def get(key)
    found = @map[key]
    if found 
      update_node!(found)
    else 
      found = @map[key] = @store.set(key, @prc.call(key))
      eject! if self.count > @max
    end
    found.val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private
  def update_node!(node)
    @store.delete(node)
    @store.set(node.key, node.val)
  end

  def eject!
    @map.delete(@store.delete(@store.first).key)
  end
end
