
#  Skiena 2008

# Prim(G)
#   Select an arbitrary vertex `s` to start tree from
#   While (there exists nontree vertices)
#       Select edge of minimum weight betwee a tree and nontree vertex
#       Add the selected edge and vertex to the tree Tprim

from collections import defaultdict

def prim(graph, start):
    parent = defaultdict(lambda: None)
    distance = defaultdict(lambda: float('inf'))
    tree = set()
    v = start 

    while v not in tree:
        tree.add(v)

        # update each of v's edges
        for edge in graph.edges(v):
            weight = edge.weight
            w = edge.vertex
            if (w not in tree) and (weight < distance[w]):
                distance[w] = weight
                parent[w] = v

        # select the vertex with min edge weight to MST
        v = min([v for v in graph.vertices if v not in tree], key=lambda v: distance[v])



    



