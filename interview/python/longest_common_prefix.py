
def longestCommonPrefix(A):
        
    shortest_str = min(A, key=len)

    i = 0
    while i < len(shortest_str):
        if not all_same(i, A):
            break
        i += 1

    return shortest_str[:i]
        
        
def all_same(i, strings):
    iterator = iter(strings)
    try:
        first = next(iterator)
    except StopIteration:
        return True
    return all(first[i] == rest[i] for rest in iterator)

