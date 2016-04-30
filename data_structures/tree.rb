

class Tree

  attr_accessor :item, :children, :parent

  def intialize(item:, children: [], parent: nil)
    @item = item
    @children = children
    @parent = parent
  end


  # Dictionary methods
  def search(key)

  end

  def insert(item)

  end

  def delete(item)

  end

  def max

  end

  def min

  end

  def pred(key)
  end

  def succ(key)
  end

  # PriorityQueue methods

end



class BinaryTree
  def intialize(item:, left: nil, right: nil, parent: nil)
    @tree = Tree.new(item: item, children: [left, right], parent: parent)
  end

  def left_child
    @tree.children[0]
  end

  def right_child
    @tree.children[1]
  end

  def item
    @tree.item
  end

  # Dictionary methods
  def search(key)

  end

  def insert(item)

  end

  def delete(item)

  end

  def max

  end

  def min

  end

  def pred(key)
  end

  def succ(key)
  end

  # PriorityQueue methods

end



# B-tree
class BalancedTree
end

class KDTree
end
