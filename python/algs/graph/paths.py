# Eric Ren 2016
# Shortest Paths algorithms

from datastructs.graph import Graph

"""

Psuedocode Adapted from Skiena 2008



"""

def dijkstra(graph):
    pass






"""
    Psuedocode Adapted from Skiena 2008
    
    C[v,w]_k = min( C[v,w]_k-1, C[v,k]_k-1 + C[k,w]_k-1)


    Notes:
    - If negative cycles exist, there is no shortest path between pairs of vertices which are part of the cycle.
    - Vertices from `Graph` labeled as ints.

"""
def floyd_warshall(graph):
    costs = [[float('inf') for _ in range(graph.num_vertices())] for _ in range(graph.num_vertices())]

    for edge in graph.all_edges():
        costs[edge.v][edge.w] = edge.weight

    vertex_cnt = graph.num_vertices();
    for k in range(vertex_cnt):
        for i in range(vertex_cnt):
            for k in range(vertex_cnt):
                costs[i][j] = min(costs[i][j], costs[i][k] + costs[k][j]);

    # TODO keep track of the paths as well, not just the costs
    return costs


