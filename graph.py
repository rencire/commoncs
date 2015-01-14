# Graph Data Structures
class GraphAM:
    def __init__(self, nverts, directed):
        self.grid = [[False for j in range(nverts)] for i in range(nverts)]
        self.directed = directed

    def is_edge(self, v1, v2):
        self.grid[v1][v2]

    def add_edge(self, v1, v2):
        self.grid[v1][v2] = True
        if not self.directed:
            self.grid[v2][v1] = True

    def remove_edge(self, v1, v2):
        self.grid[v1][v2] = False
        if not self.directed:
            self.grid[v2][v1] = False

    def get_degree(self, v):
        count = 0
        for e in self.grid[v]:
            if e:
                count += 1
        return count

class Edge:
    def __init__(self, info, weight = 1, next_edge = None):
        self.info = info
        self.weight = weight
        # self.next_edge = next_edge

class GraphAL:
    def __init__(self, nverts, directed = False):
        self.table = [None] * nverts
        self.directed = directed

    def is_edge(self, v1, v2):
        return v2 in self.table[v1]

    def get_degree(self, v):
        if self.table[v] is not None:
            return len(self.table[v])
        else:
            return 0

    def add_edge(self, v1, v2):
        self.__add_edge_helper(v1, v2)
        if not self.directed:
            self.__add_edge_helper(v2, v1)

    def __add_edge_helper(self, a, b):
        edge_list = self.table[a]
        if edge_list == None:
            self.table[a] = [b]
        else:
            edge_list.append(b)


    def remove_edge(self, v1, v2):
        edge_list = self.table[v1]
        if v2 in edge_list:
            edge_list.remove(v2)
        
        if not self.directed:
            edge_list = self.table[v2]

            if v1 in edge_list: 
                edge_list.remove(v1)
    
    

# Graph Traversal
visited = set()

def dfs(node, goalValue, visited):
    if node.value is goalValue:
        return True

    visited.add(node)
    for neighbor in node.neighbors():
        if neighbor not in visited:
            if dfs(neighbor, goalValue, visited):
                return True

    return False


def dfs2(startNode, value):
    visited = set()
    stack = [startNode]

    while len(stack) > 0:
        node = stack.pop()
        if node in visited:
            continue

        visited.add(node)
        if node.value is value:
            return True

        for n in node.neighbors:
            if n not in visited:
                stack.append(n)

    return False
