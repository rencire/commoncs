class Stack:
    """A simple stack class"""
    def __init__(self):
        self.list = list()

    def add(self, item):
        self.list.append(item)

    def pop(self):
        return self.list.pop()
