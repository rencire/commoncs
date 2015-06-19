class List
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

end

l = List.new(1, List.new(2, List.new(3)))
l.to_s

