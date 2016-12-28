# Prim's algorithm

require 'set'


EdgeNode = Struct.new(:weight, :vertex)

def prim(graph, start)

  parent = Hash.new {-1}
  distance = Hash.new {FLOAT::INFINITY}
  tree = Set.new


  v = start
  until v.nil?
    tree.add(v)

    graph.edges(v).each do |edge|
      w = edge.vertex
      if (not tree.member? w) and (edge.weight < distance[w])
        distance[w] = edge.weight
        parent[w] = v
      end
    end

    v = graph.vertices.select{|v| not tree.member? v }.min_by {|v| distance[v] }

  end
end
