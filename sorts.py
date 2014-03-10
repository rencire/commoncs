def mergesort(list):

    if len(list) < 2:
        return list

    middle = len(list)/2
    left = mergesort(list[:middle])
    right = mergesort(list[middle:])

    return merge(left, right)


def merge(left, right):
    result = []

    i,j = 0,0
    
    while(i < len(left) and j < len(right)):
        if left[i] < right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1

    result.extend(left[i:] or right[j:])
    
    return result

import random

def quicksort(list):
    if list is []:
        return []
    else:
        pivot = random.choice(list) #//pick a random pivot
        list.remove(pivot)
        lesser = [x for x in list if x <= pivot]
        greater = [x for x in list if x > pivot] 

        return quicksort(lesser) + [pivot] + quicksort(greater)
