"""
Code from Klein, 2013.


We represent the mathematical function 'f' as a 'dictionary',
and the domain of the function as a 'set'.


e.g.

Vec( {'A', 'B', 'C'}, {'A':1} )


"""

class Vec:

    def __init__(self, labels, function):
        self.D = labels
        self.f = function



def zero_vec(D):
    return Vec(D, {})


def set_item(v, d, val): 
    v.f[d] = val


def get_item(v, d):
    return v.f[d] if d in v.f else 0







