class Node
  attr_accessor :item, :next

  def initialize(item, n = nil)
    @item = item
    @next = n
  end

end

class List
  attr_accessor :head, :tail, :count

  def initialize
    @head = nil
    @tail = nil
    @count = 0
  end

  # O(n)
  def search(item)
    node = @head
    while not node.nil?
      if node.item == item
        return node
      end
      node = node.next
    end
    puts "Item not found in list"
  end

  # O(1)
  def push(item)
    node = Node.new(item)
    if @head.nil?
      @head = @tail = node
    else
      @tail.next = node
      @tail = node
    end
    @count += 1
    self
  end

  # O(1)
  def unshift(item)
    node = Node.new(item)
    if @head.nil?
      @head = @tail = node
    else
      node.next = @head
      @head = node
    end
    @count += 1
    self
  end

  # O(n)
  # NOTE: will use generic quality for comparison, not identity comparison
  def remove(item)
    return if self.search(item).nil?

    pred = self.predecessor(item)

    if pred.nil?
      node_to_remove = @head
      @head = @head.next
    else
      node_to_remove = pred.next
      pred.next = pred.next.next
    end

    # update tail
    @tail = pred if node_to_remove.next.nil?

    node_to_remove.next = nil
    @count -= 1
    self
  end

  # O(n)
  def predecessor(item)
    pred = @head
    while not pred.nil? and not pred.next.nil?
      return pred if pred.next.item == item
      pred = pred.next
    end
    puts 'Could not find predecessor in list'
  end


  def to_s
    print_header_row(:first)
    print_header_row(:second)
    print_header_row(:third)

    node = @head
    while not node.nil?
      print "#{node.item} -> "
      node = node.next
    end
    puts 'nil'
  end

  private
  def print_header_row(option)
    if @head == @tail
      if option == :first
        puts "H/T"
      elsif option == :second
        puts "|"
      elsif option == :third
        puts "v"
      end
    else
      padding = 4

      if option == :first
        print "H"
      elsif option == :second
        print "|"
      elsif option == :third
        print "v"
      end

      print " " * (padding + "#{@head.item}".length - 1)

      node = @head.next
      while not node.next.nil?
        print " " * ("#{node.item}".length + padding)
        node = node.next
      end

      if option == :first
        puts "T"
      elsif option == :second
        puts "|"
      elsif option == :third
        puts "v"
      end
    end
  end
end

