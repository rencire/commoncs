# Algorithm Adapted from Skiena 2008

# Kruskal(G)
#   Put edges in Priority Queue ordered by weight
#   count = 0
#   While (count < n -1))
#       get next edge (v,w)
#       if (component(v) != component(w))
#           Add edge to tree
#           merge component(v) and component(w)
#           count = count + 1


# Assumptions:
# - graph is an adjacency list
# - vertices are labeled by unique integers


from collections import namedtuple
from collections import defaultdict

#TODO move graph to its own data structures
# from ../../../data_structures import *

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
            e = Edge(edges[0], i, edges[1])
            all.append(e)            

        return all



def kruskal(graph):
    edges = sorted(graph.all_edges(), key=lambda e: e.weight)
    
    sets = [-1] * len(edges)

    for edge in edges:
        if not same_component(sets, edge.v, edge.w):
            union(sets, edge.v, edge.w)



"""
Union Set


We use a `sets` list to both record the parent of each item, and also the size of the set.

How do we do this?  Initially, the set is instantiated like so:

    [-1, -1, -1, -1, -1, -1]
      0   1   2   3   4   5

Negative numbers mean the item is a root. Hence initially, sets 0 to 4 are all roots. 

When we combine items (via `union` operation), we add the size of one set to another to the root element of the larger set, and assing the smaller set's root to the larger set's root. (Adding to larger set allows for shallower trees. Why?) 


In example below, set 1 has a value of -3, which means the set has a size of 3.
Sets 0 and 2 have a value of 1, meaning their parents are 1.


        1       3                      [ 1, -4,  1, -2,  3,  0]
       / \      |                        0   1   2   3   4   5
      0   2     4
      |
      5

Now when we combine sets 1 and 3, we get this:

         1                             [ 1, -6,  1,  1,  3,  0]
       / | \                             0   1   2   3   4   5                         
      0  2  3  
      |     |
      5     4

"""

def union(sets, v, w):
    root1 = find(sets, v)
    root2 = find(sets, w)

    if root1 < root2:
        sets[root2] = root1
        sets[root1] += sets[root2]
    else:
        sets[root1] = root2
        sets[root2] += sets[root1]


def same_component(sets, v, w):
    return find(sets, v) == find(sets, w)


"""
Path Compression

To find the root of a set 'x', we recursively look at the parent until we find the root (where sets[x] < 0).

However, if the set's tree height is long, it can be inefficient to traverse the parents upward.

One optimization we can do is `Path Compression`.  When we are traversing the tree to find the root of an item `x`, we can assign each node along the path to the root.

This makes the tree shallower, and hence allows future `find` operations to be faster.

Ex:

       2                                               2 
      / \                                           / | | \
     3   4           =>    find(7)    =>           7  0 3  4
    /|                                                  |
   0 8                                                  8
   | 
   7


"""
def find(sets, x):
    if sets[x] < 0:
        return x
    else:
        sets[x] = find(sets, sets[x]) 
        return sets[x]



g = Graph()
g.add_edge(1, 0)
g.add_edge(2, 0)

g.all_edges()















