require 'awesome_print'

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
  attr_reader :vertices

  def initialize(directed: false)
    @directed = directed
    @vertices = {}
  end

  def directed?
    @directed
  end

  def add_vertex(v)
    unless @vertices[v].nil?
      puts  "vertex #{v} already in graph"
      return
    end

    @vertices[v] = []
  end


  # silently fail with error message printed
  def add_edge(from:, to:)
    msg = nil
    msg = "vertex #{from} is not in graph" unless @vertices.include? from
    msg = "vertex #{to} is not in graph" unless @vertices.include? to
    msg = "edge alredy exists: #{from} -> #{to}" if not @vertices[from].nil? and @vertices[from].include? to

    return if not msg.nil?

    @vertices[from].push(to)
  end
end


##
# All algorithms derived from Skiena's procedural implementation in C.
# Skiena, ADM. 2008
##


##
# A general purpose BFS implementation.
#
#
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

# TODO write method to print BFS traversal tree
def print_tree()
end

# quick and dirty graph generator
def gen_graph()
  g = Graph.new()

  ('A'..'G').each { |char| g.add_vertex(Vertex.new(id: char)) }

  all_possible_edges = g.vertices.keys.permutation(2)
  added_vertices = []

  while g.vertices.length != added_vertices.length
    all_possible_edges.each do |pair|
      # 1/5th chance of adding an edge
      if rand < 0.10
        # puts g.vertices

        # adding both directions for undirected edge
        g.add_edge(from: pair[0], to: pair[1])
        g.add_edge(from: pair[1], to: pair[0])
        added_vertices.push(pair[0]) if not added_vertices.include?(pair[0])
        added_vertices.push(pair[1]) if not added_vertices.include?(pair[1])
      end
    end
  end

  ap g.vertices
end

gen_graph()





