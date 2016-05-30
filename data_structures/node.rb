# LinkedList Node

class Node
  attr_accessor :item, :next

  def initialize(item, n = nil)
    @item = item
    @next = n
  end

  def to_s
    if @next.nil?
      print "#{item} -> nil\n"
    else
      print "#{item} -> "
      @next.to_s
    end
  end

  def add
  end

  def remove
  end

  def predecessor
  end

  def search
  end
end

