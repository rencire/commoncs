def bin_search(array, item, low, high):
    if low > high:
        return -1
    
    mid_idx = (low + high) // 2
    if array[mid_idx] == item:
        return mid_idx
    elif array[mid_idx] > item:
        return bin_search(array, item, low, mid_idx - 1)
    else:
        return bin_search(array, item, mid_idx + 1, high)


# count occurences of 'key' in sorted array
# O(lgn + s), s = # of keys

def count_occurences(array, key, low, high):
    if low > high:
        return -1

    mid_idx = (low + high) // 2
    if array[mid_idx] == key:
        left_idx = mid_idx  
        while array[left_idx] == key and left_idx >= 0:
            left_idx -= 1

        right_idx = mid_idx
        while array[right_idx] == key and right_idx < len(array):
            right_idx += 1

        return right_idx - left_idx - 1
    elif array[mid_idx] > key:
        return count_occurences(array, key, low, mid_idx - 1)
    else:
        return count_occurences(array, key, mid_idx + 1, high)

# faster count_occruences
# O(lgn).  Faster than previous solution because we look for 'boundaries' 
# 'array' must have at least one element.
def co2(array, key):
    left_boundary = co2_helper_left(array, key, 0, len(array) - 1)
    right_boundary = co2_helper_right(array, key, 0, len(array) - 1)

    print(left_boundary)
    print(right_boundary)

    return right_boundary - left_boundary

# Function returns right index boundary (exlusive) of key.
# If 'key' not in 'array', function will either return:
#   - index of next highest value to the key (default behavior) or
#   - an index out of array range

def co2_helper_right(array, key, low, high):
    if low > high:
        return low      
    mid_idx = (low + high) // 2
    if array[mid_idx] > key:
        return co2_helper_right(array, key, low, mid_idx - 1)
    else:
        return co2_helper_right(array, key, mid_idx + 1, high)

# Function returns left index boundary (inclusive) of key
# If 'key' not in 'array', will return the first index of 0.


def co2_helper_left(array, key, low, high):
    if low > high:
        return low
    mid_idx = (low + high) // 2

    if array[mid_idx] < key:
        return co2_helper_left(array, key, mid_idx + 1, high)
    else:
        return co2_helper_left(array, key, low, mid_idx - 1)




