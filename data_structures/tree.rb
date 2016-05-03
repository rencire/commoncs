

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


  def del_min
    delete(min)
  end

  def del_max
    delete(max)
  end

  alias find_min min
  alias find_max max
end



# BinarySearchTree is a wrapper around Tree
#
# BinarySearchTree children are also BinarySearchTrees (too lazy to create a separate Node class)
class BinarySearchTree
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
  # O(n), O(logn) if balanced
  def search(key)
    _search(@tree, key)
  end


  # `@tree` should never be nil
  # O(n), O(logn) if balanced
  def insert(item)
    _insert(@tree, item)
  end

  # passing in the node to delete, not the 'item'
  def delete(node)
    # Cases:
    # 0) empty tree
    # 1) leaf node
    # 2) one child
    # 3) two children
  end

  # O(n), O(logn) if balanced
  def max
    node = @tree
    unless node.nil?
      node = node.right_child
    end
    node
  end

  # O(n), O(logn) if balanced
  def min
    node = @tree
    unless node.nil?
      node = node.left_child
    end
    node
  end


  # O(n), O(logn) if balanced
  def pred(key)
    return nil if @tree.nil? or @tree.left_child.nil?
    @tree.left_child.max
  end

  # O(n), O(logn) if balanced
  def succ(key)
    return nil if @tree.nil? or @tree.right_child.nil?
    @tree.right_child.min
  end


  # O(n), O(logn) if balanced
  def del_min
    delete(min)
  end

  # O(n), O(logn) if balanced
  def del_max
    delete(max)
  end

  alias find_min min
  alias find_max max


  private
  def _search(node, key)
    return nil if node.nil?
    return node if node.item == key

    if key < node.item
      _search(node.left_child, key)
    else
      _search(node.right_child, key)
    end
  end

  # `node` should never be nil
  def _insert(node, item)
    if item < node.item
      if node.left_child.nil?
        node.left_child = BinarySearchTree.new item: item, parent: node
      else
        _insert(node.left, item)
      end
    else
      if node.right_child.nil?
        node.right_child = BinarySearchTree.new item: item, parent: node
      else
        _insert(node.right, item)
      end
    end
  end

end



# B-tree
class BalancedTree
end

class KDTree
end
