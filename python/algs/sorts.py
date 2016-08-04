# Insertion Sort
def insertion_sort(list):
    for i in range(len(list)):
        v = list[i]
        j = i - 1
        for j in range(i-1, -1, -1): 
            if list[j] <= v:
                break
            else:
                list[j+1] = list[j]
                list[j] = v


l0 = [2,0,20,5,3]
l1 = [5,4,3,2,1]
l2 = [1,2,3,6,8]
insertion_sort(l0)
insertion_sort(l1)
insertion_sort(l2)
print(l0)
print(l1)
print(l2)





# mergesort
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

# qsort
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

# qsort from Skiena.  More efficient than above since we are not
# constantly creating new lists.

def quicksort2(lst, l, h):
    if l < h:
        p = partition(lst, l, h)
        quicksort2(lst, l, p - 1)
        quicksort2(lst, p + 1, h)


def partition(lst, l, h):
    first_high = l
    p = h

    for i in range(l, h):
        if lst[i] < lst[p]:
            tmp = lst[i]
            lst[i] = lst[first_high]
            lst[first_high] = tmp

            first_high += 1
    
    tmp = lst[p]
    lst[p] = lst[first_high]
    lst[first_high] = tmp
    
    return first_high





