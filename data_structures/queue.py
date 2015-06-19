class Queue:
    """A simple queue class"""
    def __init__(self):
        self.list = list()

    def add(self, item):
        self.list.append(item)

    def pop(self, item):
        self.list.pop(0)
