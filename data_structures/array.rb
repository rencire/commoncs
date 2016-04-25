# Eric Ren 2015
#
# Yes, we are reimplementing an array with... an Array :)

class TypeArray

  def initialize(type: Object, size:)

    raise(TypeError, "Type must be a Class", caller) unless type.kind_of? Class
    raise(TypeError, "Size must be an Integer", caller) unless size.kind_of? Integer
    raise(TypeError, "Load Factor must be a BigDecimal", caller) unless load_factor.kind_of? Float

    @type = type
    @size = size

    # - No `Boolean` class in ruby, hence not handling that case.
    # - No `Char` class either, hence using String instead. Hence, each cell in array can potentially have more than a char.

    # TODO
    # - Explore other alternatives to this.
    #   - Can we somehow define blocks and pass them in to `Array.new`, so that we don't need the switch statement here? But why do we need to change it? Would it be more readable, maintainable, better performance, etc.?
    @array = Array.new(size) {
      if type == Integer
        0
      elsif type == Float
        0.0
      elsif type == String
        ''
      end
      # otherwise, set default values to `nil`
    }
  end


  def []=(idx, value)
    check_index(idx)
    raise(TypeError, "Array can only contain items of type #{@type}", caller) unless size.kind_of? @type
    @array[idx] = value
  end

  def [](idx)
    check_index(idx)
    @array[idx]
  end

  private
  def check_index(idx)
    raise(TypeError, "Index is not an integer", caller) unless idx.kind_of? Integer
    raise(ArgumentError, "Index is not in range", caller) if idx < 0 or idx > @size - 1
  end
end
