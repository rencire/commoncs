
class Vertex
  attr_reader :id
  attr_accessor :parent
  attr_writer :discovered
  attr_writer :processed

  def initialize(id:)
    @id = id
    @discovered = false
    @processed = false
    @parent = nil
  end

  def discovered?
    @discovered
  end

  def processed?
    @processed
  end
end

##
# High level implementation of an Adjancey List graph
#
# NOTE: Graph can only have either directed edges, or undirected edges.
#
class Graph
  def initialize(directed: false)
    @directed = directed
    @vertices = {}
  end

  def directed?
    @directed
  end

  def add_vertex(v)
    @vertices[v] = [] if @vertices[v].nil?
  end

  def add_edge(from:, to:)
    @vertices[from].push(to)
  end
end


##
# ===Arguments
#
# graph: Graph to traverse
#
# start: vertext to start BFS traversal
#
# on_pre:  lambda for processing a vertex right after being marked as 'discovered',
#           but before processing edges.
#
#   lambda {|v| ...}
#
#
# on_edge: lambda that takes in an edge (from, to) for processing.
#
#   lambda {|from, to| ...}
#
#
# on_post: lambda for processing  right before being marked as 'processed', after
#           processing edges.
#
#   lambda {|v| ...}
#
def bfs(graph:, start:, on_pre:, on_edge:, on_post:)
  queue = [start]
  start.discovered = true

  until queue.empty?

    v = queue.shift()
    on_pre.call(v)

    graph.neighbors_of(v) do |n|

      on_edge.call(v, n) if (not n.processed? or graph.directed?)

      unless n.discovered?
        n.parent = v
        n.discovered = true
        queue.push(n)
      end

    end

    v.processed = true
    on_post.call(v)

  end
end

# TODO write some tests
# TODO write method to print BFS traversal tree




