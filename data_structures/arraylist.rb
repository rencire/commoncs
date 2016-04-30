
require './array.rb'

class ArrayList
  # Invariant
  def initialize(init_size: 10, threshold: 0.75)
    raise(TypeError, "Load Factor must be a Float", caller) unless threshold.kind_of? Float

    @array = TypeArray.new size: init_size
    @tail = 0
    @threshold = threshold
  end

  def []=(idx, value)
    @array[idx] = value
  end

  def [](idx)
    @array[idx]
  end

  # O(n)
  # amortized to theta(1)
  def resize
    # TODO
    # if aray is 75% full, double the array and copy all items over
  end

  # O(n) (resize)
  # amortized to theta(1)
  def add(item)
    # TODO
    # - add item to @array. resize if load exceeds threshold
    # - handle edge cases:
    #   - @array has size 0.
    #   - @array is full

    @array[@tail] = item
    @tail = @tail + 1

  end

  # O(n) (resize)
  # amortized to theta(1)
  def remove(item)
    # TODO
    # - removes first occurence of `item` in list.
    #   - uses '==', so beware if expecting eql? or equals? logic instead
    # - shifts element in array to fill in spot

    (0...@array.size).each do |i|
      if @array[i] == item
        @array[i] = nil

        # TODO
        # - consider resizing array if load is under some threshold (maybe 0.25?)

        shift_elements
        break
      end
    end

  end

  private
  #TODO
  def shift_elements(idx)
    # shift all elements to the
    # update @tail also

  end

end
