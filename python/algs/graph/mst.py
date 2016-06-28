# Eric Ren 2016


from datastructs.graph import Graph
from collections import defaultdict


"""
Psuedocode Adapted from Skiena 2008


Prim(G)
  Select an arbitrary vertex `s` to start tree from
  While (there exists nontree vertices)
      Select edge of minimum weight betwee a tree and nontree vertex
      Add the selected edge and vertex to the tree Tprim

"""



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





# Test Prim code here:








"""

Psuedocode Adapted from Skiena 2008

PsuedoCode
Kruskal(G)
  Put edges in Priority Queue ordered by weight
  count = 0
  While (count < n -1))
      get next edge (v,w)
      if (component(v) != component(w))
          Add edge to tree
          merge component(v) and component(w)
          count = count + 1


Assumptions:
- graph is an adjacency list
- vertices are labeled by unique integers

"""


def kruskal(graph):
    edges = sorted(graph.all_edges(), key=lambda e: e.weight)
    
    sets = [-1] * graph.num_vertices()

    for e in edges:
        if not same_component(sets, e.v, e.w):
            union(sets, e.v, e.w)

    return sets



"""
Union Set

Notes adapted from Schewchuck 2014
https://people.eecs.berkeley.edu/~jrs/61b/lec/33


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

    if sets[root1] < sets[root2]:
        sets[root1] += sets[root2]
        sets[root2] = root1
    else:
        sets[root2] += sets[root1]
        sets[root1] = root2


def same_component(sets, v, w):
    return find(sets, v) == find(sets, w)


"""
Path Compression

Notes adapted from Schewchuck 2014
https://people.eecs.berkeley.edu/~jrs/61b/lec/33


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




# Simple Test
g = Graph()
g.add_edge(1, 0)
g.add_edge(2, 0)


print kruskal(g)














