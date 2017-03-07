"""

Write a function to find the longest common prefix string amongst an array of strings.

Longest common prefix for a pair of strings S1 and S2 is the longest string S which is the prefix of both S1 and S2.

As an example, longest common prefix of "abcdefgh" and "abcefgh" is "abc".

Given the array of strings, you need to find the longest S which is the prefix of ALL the strings in the array.


"""

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

