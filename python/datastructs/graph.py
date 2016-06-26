from collections import namedtuple

Edge = namedtuple('Edge','weight v w')

# NOTE: Consider this: does Graph really need to be a class? Can also create a Factory method to create graphs (adjancency lists)

# Assume graph is composed of vertices labeled by integers
class Graph:

    """
        Simple adjacency list implementation of a graph.

        Each index in `self.vertices` represents a vertex.
        The value at `self.vertices[v]` is the list of edges for that vertex `v`.

        [
            vertex -> [(weight, dest_vertex), ...]
            .
            .
            .
        ]


        Example:

        [
            0  -> [(0, 1), (2, 2)]
            1  -> [(3, 2), (1, 2)]
            2  -> [(3, 2), (1, 2)]
        ]

    """

    def __init__(self, num_vertices=10):
        self.vertices = [ [] for _ in range(num_vertices) ]


    def num_vertices(self):
        return len(self.vertices)

    def edges_of(self, vertex):
        return self.vertices[vertex]


    # New vertex will be the last index of internal `self.vertices` list
    def add_vertex(self):
        self.vertices.append([])

    def rm_vertex(self, v):
        pass

    # Add directed edge (v -> w)
    def add_edge(self, v, w, weight=1):
        self.vertices[v].append((weight, w))

    def rm_edge(self, v, w):
        pass

    # Generate a list of `Edge` namedtuples.
    def all_edges(self):
        all = []

        for i in range(len(self.vertices)):
            edges = self.edges_of(i)

            if len(edges) < 1:
                continue

            for e in edges:
                named_edge = Edge(e[0], i, e[1])
                all.append(named_edge)

        return all

