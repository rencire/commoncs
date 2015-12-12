require 'awesome_print'
require 'set'

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
  attr_reader :adj_list

  def initialize(directed: false)
    @directed = directed
    @adj_list = {}
  end

  def directed?
    @directed
  end

  def add_vertex(v)
    unless @adj_list[v].nil?
      puts  "vertex #{v} already in graph"
      return
    end

    @adj_list[v] = []
  end


  # silently fail with error message printed
  def add_edge(from:, to:)
    msg = nil
    msg = "vertex #{from} is not in graph" unless @adj_list.include? from
    msg = "vertex #{to} is not in graph" unless @adj_list.include? to
    msg = "edge alredy exists: #{from} -> #{to}" if not @adj_list[from].nil? and @adj_list[from].include? to

    return if not msg.nil?

    @adj_list[from].push(to)
  end

  def neighbors(v)
    @adj_list[v]
  end

  def vertices
    @adj_list.keys
  end

  def edges_by_vertices
    @adj_list
  end

  def degree(v)
    @adj_list[v].length unless @adj_list[v].nil?
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
def bfs(graph:, start:, on_pre: -> (v){}, on_edge: -> (x,y){}, on_post: ->(v){})
  queue = [start]
  start.discovered = true

  until queue.empty?
    # puts "queue in bfs: #{queue}"
    v = queue.shift()
    # puts "v in bfs: #{v}"
    on_pre.call(v)

    graph.neighbors(v).each do |n|

      # on_edge.call(v, n) if (not n.processed? or graph.directed?)

      # puts "neighbor #{n}"
      unless n.discovered?
        n.parent = v
        n.discovered = true
        queue.push(n)
        # puts "pushed neighbor #{n}"
      end

    end

    v.processed = true
    # on_post.call(v)

  end
end





# TODO write method to print BFS traversal tree
def print_search_tree(graph, strategy: :bfs)
  if strategy == :bfs
    on_post = lambda do |v|
      puts v.id
    end

    bfs(graph: graph, start: graph.vertices.first, on_post: on_post)
  end

end

# quick and dirty 'connected' graph generator
def gen_graph(connected: true)
  graph = Graph.new()

  ('A'..'E').each { |char| graph.add_vertex(Vertex.new(id: char)) }


  # need a minimum spanning graph alg?

  all_possible_edges = graph.vertices.permutation(2)

  all_possible_edges.to_a.shuffle.each do |pair|


      # To make graph less connected, introduce a probability for adding
      # extra edges for vertices with an out-degree of 2
    if graph.degree(pair[0]) < 2 or (graph.degree(pair[0]) >= 2 and rand() < 0.10)

      graph.add_edge(from: pair[0], to: pair[1])

      # adding both directions for undirected edge
      unless graph.directed?
        graph.add_edge(from: pair[1], to: pair[0])
      end

    end
  end
  ap graph.adj_list

  graph
end


gen_graph()
# print_search_tree(gen_graph())





