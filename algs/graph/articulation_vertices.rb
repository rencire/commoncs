class Vertex
  attr_accessor :item
  def initialize(item: nil)
    @item = item
  end
end


class Graph

end

class SearchState

  attr_accessor :discoverd, :processed, :parent, :entry_time, :exit_time, :time
  def initialize
    @discovered = Hash.new(false)
    @processed = Hash.new(false)
    @parent = {}
    @entry_time = {}
    @exit_time = {}
    @time = 0
  end

end

# Articulation Vertices
#
module AV
  include Traversal

  # Given a graph, finds the articulation vertices
  # Graph must be undirected, otherwise behavior undefined.
  def self.find_vertices(graph)
    reachable_ancestor = {}

    proc_early = proc do |v|

    end

    proc_edge = proc do |from, to|
      # tree edge:
      #   update out_degree[from] (need to test for root av in `proc_late`)
      #
      # back edge:
      #   update reachable_ancestor[from] if entry_time[to] < entry_time[reachable_ancestor[from]]

    end

    proc_late = proc do |v|
      # return v if not an AV node (not root, bridge, nor parent)
      # update reachable_ancestor[parent[v]] if
      #  reachable_ancestor[v]'s entry time < reachable_ancestor[parent[v]]
    end

    # pick arbitrary starting node
    dfs(graph: graph, start: graph.random_vertex,
        proc_early: proc_early, proc_edge:  proc_edge, proc_late: proc_late)

  end



end


# Include all common graph traversal algs
# DFS, BFS, etc.
#
# TODO does it make sense for this to be a class or a module?
# Do we need to instantiate a 'Traversal'?
#
# Or is it more of a collection of helper methods?
module Traversal

  @@state = SearchState.new

  def self.dfs(graph:, v:, proc_early: ->(){}, proc_edge: ->(){}, proc_late: ->(){})
    @@state.discovered[v] = true
    @@state.entry_time[v] = @@state.time
    # puts "pre: #{time}"
    @@state.time = @@state.time + 1

    proc_early.call(v)

    graph.neighbors(v).each do |n|
      if !@@state.discovered[n]
        @@state.parent[n] = v
        proc_edge.call(v, n)
        self.dfs(
          graph: graph,
          vertex: n,
          proc_early: proc_early,
          proc_edge: proc_edge,
          proc_late: proc_late
        )
      elsif (@@state.parent[v] != n and !@@state.processed[n]) or graph.directed?
        # puts "vertex: #{vertex.id}, n: #{n.id}, n_obj: #{n}, vertex.parent_obj: #{vertex.parent}"
        proc_edge.call(v, n)
      end
    end

    proc_late.call(v)

    @@state.exit_time[v] = @@state.time
    # puts "post: #{time}"
    @@state.time = @@state.time + 1
    @@state.processed[v] = true
  end

  def bfs

  end

  # TODO
  # Need to make this method private somehow...

  def _dfs()

  end



end



