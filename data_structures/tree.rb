

class TreeNode
  attr_accessor :item, :children, :parent

  def intialize(item:, children: [], parent: nil)
    @item = item
    @children = children
    @parent = parent
  end
end

class Tree

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
  end

  def del_max
  end

  alias find_min min
  alias find_max max
end



# BinarySearchTree is a wrapper around Tree
#
# BinarySearchTree children are also BinarySearchTrees (too lazy to create a separate Node class)


class BinaryNode
  def initialize(left: nil, right: nil, parent: nil)
    @node = nodeNode.new(item: item, children: [left, right], parent: parent)
  end

  def left_child
    @node.children[0]
  end

  def left_child=(c)
    @node.children[0] = c
  end

  def right_child
    @node.children[1]
  end

  def right_child=(c)
    @node.children[1] = c
  end

  def item
    @node.item
  end

  def parent
    @node.parent
  end

  def is_leaf?
    left_child.nil? and right_child.nil?
  end
end

class BinarySearchTree

  def intialize
    @root = nil
  end


  # Dictionary methods
  # O(n), O(logn) if balanced
  def search(key)
    _search(@root, key) do |node, k|
      return -1 if node.item < k
      return 0 if node.item == k
      return 1 if node.item > k
    end
  end

  # O(n), O(logn) if balanced
  def insert(item)
    if @root.nil?
      @root = BinaryNode.new item: item
      return
    end

    _insert(@root, item)
  end

  # NOTE:
  # passing in the node object to delete, not the 'item'
  #
  # O(n) since our implementation checks if node exists in tree first.
  # O(1) otherwise if we don't need to check
  #
  # TODO
  # consider refactoring out the cases. getting cumbersome to read the code.
  def delete(node)
    # Cases:
    # 0) root is nil
    return if @root.nil?

    # check if node object exists in tree
    found = _search(@root, node) do |n, key|
      return -1 if n.item < key.item
      return 0 if n == key
      return 1 if n.item > key.item
    end

    if found.nil?
      raise Exception("Cannot delete node; #{node} is not in tree")
    end


    # 1) leaf node
    if node.is_leaf? and node == @root
      @root = nil
      return
    end

    if node.is_leaf? and node == node.parent.left_child
      node.parent.left_child = nil
      return
    end

    if node.is_leaf? and node == node.parent.right_child
      node.parent.right_child = nil
      return
    end


    # 2) one child
    # TODO
    # Refactor this. Code is not very 'DRY'
    if !node.left_child.nil? and node.right_child.nil?

      if node == @root
        @root = node.left_child
        return
      end

      if node.parent.left_child == node
        node.parent.left_child = node.left_child
      else
        node.parent.right_child = node.left_child
      end

      # unlink `node` from rest of tree
      node.parent = nil
      node.left_child = nil
      node.right_child = nil

      return
    end

    if node.left_child.nil? and !node.right_child.nil?
      if node == @root
        @root = node.right_child
        return
      end

      if node.parent.left_child == node
        node.parent.left_child = node.right_child
      else
        node.parent.right_child = node.right_child
      end

      # unlink `node` from rest of tree
      node.parent = nil
      node.left_child = nil
      node.right_child = nil

      return
    end


    # 3) two children
    # this is going to be a hairy solution...
  end

  # O(n), O(logn) if balanced
  def max
    return if @root.nil?
    _max(@root)
  end


  # O(n), O(logn) if balanced
  def min
    return if @root.nil?
    _min(@root)
  end


  # O(n), O(logn) if balanced
  def pred(key)
    return nil if @root.nil? or @root.left_child.nil?
    _max(@root.left_child)
  end

  # O(n), O(logn) if balanced
  def succ(key)
    return if @root.nil? or @root.right_child.nil?
    _min(@root.right_child)
  end


  # O(n), O(logn) if balanced
  def del_min
    return if @root.nil?
    delete(min)
  end

  # O(n), O(logn) if balanced
  def del_max
    return if @root.nil?
    delete(max)
  end

  alias find_min min
  alias find_max max


  private
  # Takes in a comparitor to determine comparison
  def _search(node, key)
    return nil if node.nil?
    return node if yield(node, key) == 0

    if yield(node, key) == -1
      _search(node.left_child, key)
    elsif yield(node, key) == 1
      _search(node.right_child, key)
    else
      raise Exception "Comparitor #{comp} did not return 0, -1, nor 1"
    end
  end

  # `node` should never be nil
  def _insert(node, item)
    if item < node.item
      if node.left_child.nil?
        node.left_child = BinaryNode.new item: item, parent: node
      else
        _insert(node.left, item)
      end
    else
      if node.right_child.nil?
        node.right_child = BinaryNode.new item: item, parent: node
      else
        _insert(node.right, item)
      end
    end
  end

  def _max(node)
    unless node.right_child.nil?
      node = node.right_child
    end
    node
  end

  def _min(node)
    unless node.nil?
      node = node.left_child
    end
    node
  end
end



# B-tree
class BalancedTree
end

class KDTree
end
