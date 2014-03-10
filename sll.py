class Node:
    """A simple singly list node class"""
    def __init__(self, item):
        self.item = item
        self.next = None

class SLinkedList:
    """A simple singly linked list class"""

    def __init__(self):
        self.head = None
        self.tail = None
        self.count = 0

    def add(self, index):
        pass

    def add_end(self, n):
        new_node = Node(n)

        if self.head is None:
            self.head = new_node

        if self.tail is not None:
            self.tail.next = new_node

        self.tail = new_node
        self.count += 1

    def add_front(self, n):
        new_node = Node(n)

        if self.head is None:
            self.head = new_node            
            self.tail = new_node            
        else:
            new_node.next = self.head
            self.head = new_node
        self.count += 1

    def remove(self, index):
        if index >= self.count or index < 0:
            #return an index out of bounds error
            return
        else:
            prev_node = None
            cur_node = self.head
            while((cur_node is not None) and (index > 0)):
                prev_node = cur_node
                cur_node = cur_node.next
                index = index - 1

            if prev_node is not None:
                prev_node.next = cur_node.next
            else:
                self.head = cur_node.next

            # if cur_node was last node, we need to point tail to prev_node
            if cur_node.next is None:
                self.tail = prev_node
            
            cur_node.next = None
            self.count -= 1
        
    def remove_front(self):
        # if self.head is None:
        #     # return 'cannot remove from empty list' error
        #     return
        # else:
        #     old_node = self.head
        #     self.head = self.head.next
        #     old_node.next = None

        #     if self.head.next is None:
        #         self.tail = self.head
 
        #     self.count -=1
        self.remove(self,0)

    def remove_end(self):
        self.remove(self,count-1)    

    def print_list(self):
        node = self.head
        while (node is not None):
            print(node.item)
            node = node.next


        


