class Node:
    def __init__(self, key, value):
        self.key = key
        self.value = value

    def __lt__(self, other):
        self.key < other.key

    def __le__(self, other):
        self.key <= other.key

    def __gt__(self, other):
        self.key > other.key

    def __ge__(self, other):
        self.key >= other.key


class BHeap:
    """A simple binary heap class"""

    def __init__(self):
        self.hlist = [0]
        self.size = 0
    
    def min(self):
        if self.size:
            return None
        else:
            return self.list[1]

    def insert(self, item):
        self.hlist.append(item)
        self.size += 1
        self.bubbleUp(self.size)

    def bubbleUp(self, i):
        new_item = self.hlist[i]
        while i // 2 > 0:
            p_i = i // 2
            parent = self.hlist[p_i]
            if new_item < parent:
                self.hlist[i] = parent
                i = p_i
            else:
                break
        self.hlist[i] = new_item
        


    def deleteMin(self):
        if len(self.hlist):
            ret_item = self.hlist[1]
            self.hlist[1] = self.hlist[self.size]
            self.size -= 1
            self.hlist.pop()
            self.bubbleDown(1)
            return ret_item
        else:
            return None

    def bubbleDown(self, i):
        top_item = self.hlist[i]
        while i * 2 <= self.size:  
            mci = self.minChild(i)
            min_child = self.hlist[mci]
            if top_item > min_child:
                self.hlist[i] = min_child
                i = mci
            else:
                break
        self.hlist[i] = top_item



    def minChild(self, i):
        # if right child doesn't exist (meaning we're at the end of the heap list)
        if i * 2 + 1 > self.size:
            return i * 2
        if self.hlist[i * 2] < self.hlist[i * 2 + 1]:
            return i * 2
        else:
            return i * 2 + 1


