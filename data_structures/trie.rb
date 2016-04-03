# High level implementation of a Trie
#
#
# Links:
# https://en.wikipedia.org/wiki/Trie
# https://en.wikipedia.org/wiki/Trie#cite_note-brass-2
# http://web.archive.org/web/20080623071352/http://www.ddj.com/windows/184410528
# https://github.com/kanwei/algorithms/blob/master/lib/containers/trie.rb
#
#
#
# If considering using a trie to store dictionary words, consider
# using a Deterministic Acyclic Finite State Automata (DAFSA)
#
# https://en.wikipedia.org/wiki/Deterministic_acyclic_finite_state_automaton
#

class Node
  attr_accessor :value, :key
  def initialize(key: '', val: nil, children: [])
    @key = key
    @value = val
    @children = children
  end

  def get_child(char)
    @children.find {|n| n.key == char}
  end

  def add_child(node)
    @children.push(node)
  end
end



# TODO
# Implement a Ternary Search tree, as it combines the time efficiency of a full trie (digital search tree) with the space efficiency of a binary search tree
#
# Current implementation is a basic Trie.

class Trie

  def initialize
    @root = Node.new
  end


  # TODO
  # Iterative implementation.  Try recursive
  #
  # insert("abc", 3) will overwrite previous insertion of "abc".
  #
  # Time Complexity: O(N)
  def insert(str:, val:)
    if str.empty?
      raise "Empty string given"
    end

    i = 0
    n = str.length

    # Now lets Walk tree to find node w/ character as key
    node = @root
    while i < n
      child = node.get_child(str[i])
      break if child.nil?
      node = child
      i = i + 1
    end

    # Otherwise, we found leaf node. Now we add new path of remaining chars to trie
    while i < n
      new_leaf = Node.new(key: str[i])
      node.add_child(new_leaf)
      node = new_leaf
      i = i + 1
    end

    node.value = val

  end

  # TODO
  # Iterative implementation.  Try recursive
  #
  # Time Complexity: O(N)
  def get(str:)
    i = 0
    n = str.length

    node = @root
    while i < n
      child = node.get_child(str[i])
      # key not found
      return nil if child.nil?
      node = child
      i = i + 1
    end

    node.value
  end

  def pretty_print
    # TODO
  end

end
