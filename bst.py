class Node:
    def __init__(self, item, key = None, left = None, right = None, parent = None):
        self.key = key
        self.item = item
        self.left = left
        self.right = right
        self.parent = parent

    def find_min(self):
        min_item = self.item
        tree = self.left
        while (tree is not None):
           min_item = tree
           tree = tree.left
        return min_item

    def find_max(self):
        max_item = self.item
        tree = self.right
        while (tree is not None):
           max_item = tree
           tree = tree.right
        return max_item

    def bin_ins(self, node):
        if node.item <= self.item:
            if self.left is None:
                self.left = node
                node.parent = self
            else:
                self.bin_ins(self.left, node)
        else:
            if self.right is None:
                self.right = node
                node.parent = self
            else:
                self.bin_ins(self.right, node)

    def bin_del(self, key):
        if key < self.key:
            self.left.bin_del(key)
        elif key > self.key:
            self.right.bin_del(key)
        else:
            #found key, now delete it

            # if node has two children
            if self.left and self.right:
                successor = self.right.find_min_node()
                self.key = successor.key
                successor.bin_del(successor.key)
            elif self.left:
                if self.parent:
                    if self is self.parent.left:
                        self.parent.left = successor

            pass


    def replace_
class Bst:
    """A simple Binary Search Tree"""

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
        self.root.find_min()
    
    def find_max(self):
        self.root.find_max()

    def insert(self, item):
        node = Node(item)
        if self.root is None:
            self.root = node
        else:
            self.root.bin_ins(node)

    
    def delete(self, item):
        pass

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



