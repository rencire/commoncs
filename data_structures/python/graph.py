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

    def __init__(self, num_vertices=10, directed=true):
        self._vertices = [ [] for _ in range(num_vertices) ]
        self.is_directed = directed        

    def num_vertices(self):
        return len(self._vertices)


    def get_vertices(self):
        return list(range(self.num_vertices))

    def edges_of(self, vertex):
        return self._vertices[vertex]


    # New vertex will be the last index of internal `self._vertices` list
    def add_vertex(self):
        self._vertices.append([])

    def rm_vertex(self, v):
        pass

    def add_edge(self, v, w, weight=1):
        self._vertices[v].append((weight, w))

        if not self.is_directed:
            self._vertices[w].append((weight, v))


    def rm_edge(self, v, w):
        pass

    # Generate a list of `Edge` namedtuples.
    def all_edges(self):
        all = []

        for i in self.get_vertices():
            edges = self.edges_of(i)

            if len(edges) < 1:
                continue

            for e in edges:
                named_edge = Edge(e[0], i, e[1])
                all.append(named_edge)

        return all

