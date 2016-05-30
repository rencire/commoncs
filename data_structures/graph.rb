# Adjacency list implementation

class Vertex
  attr_accessor :item
  def initialize(item)
    @item
  end

  def to_s

  end
end


class Graph

  def initialize(directed: false)
    @directed = directed
    @list = {}
  end

  def add_vertex(v)
    if @list[v].nil?
      @list[v] = []
    else
      raise "Vertex #{v} already in graph"
    end
  end
end
