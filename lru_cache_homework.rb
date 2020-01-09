class LRUCache
  def initialize(n)
    @length = n
    @idx = -1
    @cache = Hash.new { |h,k| @idx += 1; h[@idx] = k }
  end

  def inspect
    show
  end

  def count
    # returns number of elements currently in cache
    @cache.length
  end

  def add(el)
    # adds element to cache according to LRU principle
    present = get_item(el)

    if present
      update_item(*present)
    else
      @cache[el]
      delete_oldest() if count > @length
    end
  end

  def show
    # shows the items in the cache, with the LRU item first
    print @cache
    puts "---"
    @cache.to_a.sort { |(k1,v1),(k2,v2)| k1 <=> k2 }.reduce([]) { |memo, (k,v)| 
      memo << v
    }
  end

  private
  # helper methods go here!
  def get_item(item)
    @cache.each do |(k,v)|
      return [k, v] if v == item
    end
    nil
  end

  def update_item(key, item)
    @cache.delete(key)
    @cache[item]
  end

  def delete_oldest
    @cache.delete(@cache.keys.min)
  end
end
