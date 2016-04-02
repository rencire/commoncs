class Node < Struct.new(:item, :children)
  def intialize(item: nil, children: []); super(item, children) end
end

class Trie

  def initialize
  end

  def insert(str)

    if str.empty?
      puts "Empty string given"
      return
    end

    first_char = str[0]
    rest_of_str = str[1..-1]

    # Empty trie
    if @root.nil?
      @root = Node.new(first_char)
      add_new_path(@root, rest_of_str)
      puts "Finished adding #{str} to trie"
      return
    end

    # Trie has only one root, so first char must match root
    if @root.item != first_char
      puts "Root does not match first char of given string: #{str}"
      return
    end

    # Now lets Walk tree to find leaf node
    leaf = @root

    unless rest_of_str.empty?
      child = leaf.children.find {|n| n.item == rest_of_str[0]}

      break if child.nil?

      leaf = child
      rest_of_str = rest_of_str[1..-1]
    end

    # If we found all chars, exit
    if rest_of_str.empty?
      puts "String '#{str}' Already exists in trie"
      return
    end

    # Otherwise, we found leaf node. Now we add new path of remaining chars to trie
    add_new_path(leaf, rest_of_str)
    puts "Finished inserting #{str} to trie"
  end


  def add_new_path(leaf, str)
    str.chars.each do |c|
      new_leaf = Node.new(c)
      leaf.children.push(new_leaf)
      leaf = new_leaf
    end
    puts "Inserted rest of string to trie: #{str}"
  end


end
