# Prim's algorithm


def prim(graph, start)

  parent = Hash.new {-1}
  distance = Hash.new {FLOAT::INFINITY}
  in_tree = Hash.new {false}


  v = start
  until v.nil?
    in_tree[v] = true

    # e is an EdgeNode.  It has weight `w` and destination vertex `to`
    graph.edges(v).each do |edge|
      to = edge.to
      if !in_tree[to] and edge.weight < distance[to]
        distance[to] = edge.weight
        parent[to] = v
      end
    end

    v = graph.vertices.select{|v| !in_tree[v] }.min_by {|v| distance[v] }

  end
end
