

class Tree():

    def __init__(self, item, left, right):
        self.item = item
        self.left = left
        self.right = right




def preorder(tree, fn):
    if tree == None:
        return

    fn(tree)
    preorder(tree.left, fn)
    preorder(tree.right, fn)




def inorder(tree, fn):
    if tree == None:
        return

    inorder(tree.left, fn)
    fn(tree)
    inorder(tree.right, fn)




def postorder(tree, fn):
    if tree == None:
        return

    postorder(tree.left, fn)
    postorder(tree.right, fn)
    fn(tree)
