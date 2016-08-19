# Eric Ren 2016
# Shortest Paths algorithms

from datastructs.graph import Graph
from collections import defaultdict

"""

Psuedocode Adapted from Skiena 2008

Dikjstra(G, s, t)
    known = {s}
    for i = 1 to n, dist[i] = INFINITY
    for each edge  (s,v), dist[v] = w(s,v)
    last = s
    while (last != t)
        select v_next, the unknown vertex minimizing dist[v]
        for each edge (v_next, x):
            dist[x] = min(dist[x], dist[v_next] + w(v_next,x))
        last = v_next
        known = union known with {v_next}

NOTE:
    - almost the same as Prim's algorithm
"""

def dijkstra(graph, start):
    parent = defaultdict(lambda: None)
    distance = defaultdict(lambda: float('inf'))
    tree = set()

    distance[start] = 0
    v = start

    while v not in tree:
        tree.add(v)

        # each edge represented as EdgeNode
        for edge in graph.edges(v):
            weight = edge.weight
            w = edge.vertex
            if (w not in tree) and (distance[v] + weight < distance[w]):
                distance[w] = distance[v] + weight
                parent[w] = v

        v = min([v for v in graph.vertices if v not in tree],
                key=lambda v: distance[v])




"""
- Slower than Dijkstra's, but capable of handling graphs with negative numbers
"""
def bellman_ford(graph):
    pass




"""
    Psuedocode Adapted from Skiena 2008
    
    C[v,w]_k = min( C[v,w]_k-1, C[v,k]_k-1 + C[k,w]_k-1)


    Notes:
    - If negative cycles exist, there is no shortest path between pairs of vertices which are part of the cycle.
    - Assume no negative cycles.
    - Vertices from `Graph` labeled as ints.

"""
def floyd_warshall(graph):
    vertex_cnt = graph.num_vertices();

    costs = [[float('inf') for _ in range(vertex_cnt)] for _ in range(vertex_cnt)]

    for v in range(vertex_cnt):
        costs[v][v] = 0

    for edge in graph.all_edges():
        costs[edge.v][edge.w] = edge.weight

    for k in range(vertex_cnt):
        for i in range(vertex_cnt):
            for k in range(vertex_cnt):
                costs[i][j] = min(costs[i][j], costs[i][k] + costs[k][j]);

    # TODO keep track of the paths as well, not just the costs
    return costs


