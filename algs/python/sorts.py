# Insertion Sort
# - sorted and unsorted halves of the array
# - in-place

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





# TODO
# - selection sort
# - bubble sort
# - heap sort



## Selection sort
# - split list into 'sorted' and 'unsorted' halves
# - select
# - in-place

# very imperative
def selection_sort(list):
    for i in range(len(list)):

        min = list[i]
        min_idx = i
        for j in range(i+1, len(list)):
            if list[j] < min:
                min = list[j]
                min_idx = j

        tmp = list[i]
        list[i] = list[min_idx]
        list[min_idx] = tmp



# less imperative
def selection_sort1(list):
    for i in range(len(list)):
        min_idx = min(range(i, len(list)), key=list.__getitem__)
        swap(list, i, min_idx)

def swap(list, i, j):
    tmp = list[i]
    list[i] = list[j]
    list[j] = tmp













## Mergesort

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


# More functional Mergesort

"""
 note:
 - very inefficient, no TCO in python

"""

def mergesort2(items):
    if len(items) < 2:
        return items
    else:
        m = len(items) // 2
        return merge2( mergesort2(items[:m]), mergesort2(items[m:]) )


def merge2(left, right):
    if len(left) == 0:
        return right
    elif len(right) == 0:
        return left
    elif left[0] < right[0]:
        return [ left[0] ] + merge2( left[1:], right )
    else:
        return [ right[0] ] + merge2( left, right[1:] )




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




test_cases = [
    [2,0,20,5,3],
    [5,4,3,2,1],
    [1,2,3,6,8],
    [1,1,1,1,1]
]

def test_in_place_sorts(name, func):
    print(name)
    for test_case in test_cases:
        func(test_case)
        print(test_case)

def test_out_of_place_sorts(name, func):
    print(name)
    for test_case in test_cases:
        res = func(test_case)
        print(res)


test_in_place_sorts("Insertion sort", insertion_sort)
test_in_place_sorts("Selection sort", selection_sort)
test_in_place_sorts("Selection sort1", selection_sort1)
