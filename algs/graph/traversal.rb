require 'awesome_print'
require 'graphviz'

class Vertex
  attr_reader :id
  attr_accessor :parent, :pre, :post
  attr_writer :discovered
  attr_writer :processed

  def initialize(id:)
    @id = id
    @discovered = false
    @processed = false
  end

  def discovered?
    @discovered
  end

  def processed?
    @processed
  end

  def reset
    @parent = @pre = @post = nil
    @discovered = @processed = false
  end
end

##
# High level implementation of an Adjancey List graph
#
# NOTE: Graph can only have either directed edges, or undirected edges.
#
class Graph
  attr_reader :adj_list, :num_of_edges, :num_of_vertices

  def initialize(directed: false)
    @directed = directed
    @adj_list = {}
    @num_of_edges = 0
    @num_of_vertices = 0
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
    @num_of_vertices = @num_of_vertices + 1
  end


  # silently fail with error message printed
  def add_edge(from:, to:)
    msg = nil
    msg = "vertex #{from} is not in graph" unless @adj_list.include? from
    msg = "vertex #{to} is not in graph" unless @adj_list.include? to
    msg = "edge alredy exists: #{from} -> #{to}" if not @adj_list[from].nil? and @adj_list[from].include? to

    return if not msg.nil?

    @adj_list[from].push(to)
    # undirected edge is stored as 2 direct edges
    @num_of_edges = @num_of_edges + 1
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


  # perform dfs to check if current graph is connected
  def connected?
    visited = Set.new
    on_pre = lambda do |v|
      visited.add(v)
    end

    dfs(graph: self, vertex: self.vertices().first, on_pre: on_pre)

    # need to reset vertex's state for next traversal
    self.reset()

    # puts "visited.length: #{visited.length}"
    # puts "num_of_vertices: #{self.num_of_vertices}"
    # puts "num_of_edges: #{self.num_of_edges}"
    return visited.length == self.num_of_vertices
  end

  def reset
    self.vertices.each {|v| v.reset()}
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
def bfs(graph:, vertex:, on_pre: -> (v){}, on_edge: -> (x,y){}, on_post: ->(v){})
  queue = [vertex]
  vertex.discovered = true

  until queue.empty?
    v = queue.shift()
    on_pre.call(v)

    graph.neighbors(v).each do |n|

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

def dfs(graph:, vertex:, on_pre: -> (v){}, on_edge: -> (x,y){}, on_post: ->(v){}, time: 1)

  vertex.discovered = true
  vertex.pre = time
  # puts "pre: #{time}"
  time = time + 1

  on_pre.call(vertex)

  graph.neighbors(vertex).each do |n|
    if !n.discovered?
      n.parent = vertex
      on_edge.call(vertex, n)
      time = dfs(graph: graph, vertex: n, on_pre: on_pre, on_edge: on_edge, on_post: on_post, time: time)
    elsif (vertex.parent != n and !n.processed?) or graph.directed?
      puts "vertex: #{vertex.id}, n: #{n.id}, n_obj: #{n}, vertex.parent_obj: #{vertex.parent}"
      on_edge.call(vertex, n)
    end
  end

  on_post.call(vertex)

  vertex.post = time
  # puts "post: #{time}"
  time = time + 1
  vertex.processed = true

  return time

end

# TODO handle directed edges
#
# Helpful links for using GraphViz library:
#
# https://github.com/glejeune/Ruby-Graphviz
# http://www.rubydoc.info/github/glejeune/Ruby-Graphviz
# http://www.graphviz.org/doc/info/attrs.html
#
def draw_graph(graph)
  type = graph.directed? ? :digraph : :graph
  g = GraphViz.new(:G, :type => type)
  graph.vertices().each do |v|
    g.add_node(v.id)
  end

  added_edges = Set.new

  graph.edges_by_vertices().each do |x, edges|
    from = g.get_node(x.id)
    edges.each do |y|
      to = g.get_node(y.id)

      if graph.directed?
        # draw each individual 'directed' edge
        g.add_edge(from, to)
      else
        # draw only one edge to represent 'undirected' edge
        g.add_edge(from, to) unless added_edges.include?([to, from])
        added_edges.add([from, to])
      end


    end
  end


  filename = "graph.png"
  g.output( :png => filename )
  system("open #{filename}")
end

def draw_search_tree(graph, strategy: :bfs)
  tree = GraphViz.new( :G, :type => :graph )

  if strategy == :bfs
    on_pre = lambda do |v|
      tree.add_node(v.id)
    end

    on_edge = lambda do |x,y|
      from = tree.get_node(x.id)

      if !y.discovered? # tree edge
        to = tree.add_node(y.id)
        tree.add_edge(from, to)
      else # cross edge for undirected graph. could also be back (maybe forward?) edge for directed graphs
        # grab y from tree since we've already 'discovered' it
        to = tree.get_node(y.id)
        tree.add_edge(from, to, dir: 'forward', constraint: false)
      end
    end

    bfs(graph: graph, vertex: graph.vertices().first, on_pre: on_pre, on_edge: on_edge)

  elsif strategy == :dfs
    on_pre = lambda do |v|
      tree.add_node(v.id)
    end

    on_edge = lambda do |x,y|
      from = tree.get_node(x.id)
      edge_type = classify_edge(x,y)
      # puts edge_type

      if edge_type == :tree
        to = tree.add_node(y.id)
        tree.add_edge(from, to)
      elsif edge_type == :back or edge_type == :cross or edge_type == :forward
        to = tree.get_node(y.id)
        tree.add_edge(from, to, dir: 'forward', constraint: false)
      end
    end

    dfs(graph: graph, vertex: graph.vertices().first, on_pre: on_pre, on_edge: on_edge)

  end

  # generate and open graph image
  filename = "#{strategy}_traversal.png"
  # puts filename
  tree.output( :png => filename )
  system("open #{filename}")
  # puts "done writing #{filename}"

end

# classify the edge x -> y
def classify_edge(x,y)
  if y.parent == x
    return :tree
  elsif y.discovered? and !y.processed?
    return :back
  elsif y.processed? and y.pre < x.pre
    return :cross
  elsif y.processed? and x.pre < y.pre
    return :forward
  end
end


# quick and dirty 'connected' graph generator
#
# NOTE:
#  - Currently we are ensuring the graph is connected by running DFS on itself
#    after everytime we add an edge.
#
#    Consider building a minimum spanning tree instead.
#
# TODO handle generatng directed edges
#  - for directed graphs, current strategy of checking for connectivity is not
#     optimal.
#
#     Consider the situation where we add edges until all nodes are
#     'connected', and the starting vertex for traversal is a 'sink'.
#
#     Since it's a sink, DFS cannot visit any other vertex, and thus `gen_graph()`
#     will continue adding edges until DFS can traverse other nodes.
#
#     This behavior can add a lot of unecessary edges, such as both (A->B) and
#     (B->A). As a result, the graph will be very connected, and look messy.
#
#
def gen_graph(connected: true, directed: false)
  graph = Graph.new(directed: directed)

  ('A'..'G').each { |char| graph.add_vertex(Vertex.new(id: char)) }

  all_possible_edges = graph.vertices().permutation(2)

  all_possible_edges.to_a.shuffle.each do |pair|

    break if graph.connected? and connected

    graph.add_edge(from: pair[0], to: pair[1])

    # adding both directions for undirected edge
    unless graph.directed?
      graph.add_edge(from: pair[1], to: pair[0])
    end


    #   # Graph is guaranteed to be connected if out-degree of each vertext is at least 2
    #   # To make graph less connected, introduce a probability for adding
    #   # extra edges for vertices which already have an out-degree of 2
    # if graph.degree(pair[0]) < 2 or (graph.degree(pair[0]) >= 2 and rand() < 0.10)
    #
    #   graph.add_edge(from: pair[0], to: pair[1])
    #
    #   # adding both directions for undirected edge
    #   unless graph.directed?
    #     graph.add_edge(from: pair[1], to: pair[0])
    #   end
    #
    # end
  end
  ap graph.adj_list

  graph
end

graph = gen_graph()

draw_graph(graph)
draw_search_tree(graph, strategy: :dfs)
graph.reset()
draw_search_tree(graph, strategy: :bfs)





