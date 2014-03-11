class Node:
    def __init__(self, item, key = None, left = None, right = None, parent = None):
        self.key = key
        self.item = item
        self.left = left
        self.right = right
        self.parent = parent

    
class Bst:
    """A simple Binary Search Tree
    
    Implementation uses nodes with parent pointers.  
    Might be useful later for balancing trees.
    """

    def __init__(self, root = None):
        self.root = root
        self.size = 0
    
    def search(self, item):
        node = self.root
        while node is not None:
            if node.item == item:
                return item
            else:
                if tree.item < item:
                    node = node.left 
                else: 
                    node = node.right
        return node
    
    def find_min(self):
        node = self._find_min_node()
        return node.item

    def _find_min_node(self, root):
        node = root
        while node.left:
            node = node.left
        return node
 
    def find_max(self):
        node = self._find_max_node()
        return node.item
   
    def _find_max_node(self, root):
        node = root
        while node.right:
            node = node.right
        return node

    def insert(self, key, value):
        node = Node(key, value)
        if self.root is None:
            self.root = node
        else:
            self._insert_helper(self.root, node)
        self.size += 1

    def _insert_helper(self, node, new_node):
        if new_node.item <= node.item:
            if node.left is None:
                node.left = new_node
                new_node.parent = node
            else:
                self._insert_helper(node.left, new_node)
        else:
            if node.right is None:
                node.right = new_node
                new_node.parent = node
            else:
                self._insert_helper(node.right, new_node)


    def delete(self, key):
            self._delete_helper(self.root, key)

    #recursive solution
    # node - node to start search for key
    # key - key to delete
    def _delete_helper(self, node, key):
        if node is None:
            raise KeyError(str(key))
        else:
            if key < self.key:
                node = node.left
                self._delete_helper(node, key)
            elif key > self.key:
                node = node.right
                self._delete_helper(node, key)
            else:
                #found key, now delete it
                # node has two children
                if node.left and node.right:
                    successor = self._find_min_node(node.right)
                    node.key = successor.key
                    node.item = successor.item

                    self._delete_helper(successor, successor.key)
                # node has left child only
                else:
                    if node.left:
                        if node.parent:
                            if node.parent.left is node:
                                node.parent.left = node.left
                            else:
                                node.parent.right = node.left
                            node.left.parent = node.parent
                        else:
                            self.root = node.left
                    # node has right child only
                    elif node.right:
                        if node.parent:
                            if node.parent.right is node:
                                node.parent.right = node.right
                            else:
                                node.parent.right = node.right
                            node.right.parent = node.parent
                        else:
                            self.root = node.right
                    # node has no children
                    else: 
                        if node.parent:
                            if node.parent.left is node:
                                node.parent.left = None
                            else:
                                node.parent.right = None
                        else:
                            self.root = None
                    self.size -= 1

    
    def traverse(self, func, order):
        if order is 'in':
            self.inOrderTrav(self.root, func)
        elif order is 'pre':
            self.preOrderTrav(self.root, func)
        elif order is 'post':
            self.postOrderTrav(self.root, func)
        else:
            print('Error: do not understand order')

    def inOrderTrav(self, node, func):
        if node is None:
            return
        else:
            self.inOrderTrav(node.left, func)
            func(node)
            self.inOrderTrav(node.right, func)

    def preOrderTrav(self, node, func):
        if node is None:
            return
        else:
            func(node)
            self.preOrderTrav(node.left, func)
            self.preOrderTrav(node.right, func)

    def postOrderTrav(self, node, func):
        if node is None:
            return
        else:
            self.postOrderTrav(node.left, func)
            self.postOrderTrav(node.right, func)
            func(node)

    def printTree(self):
        pass        

