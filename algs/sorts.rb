# 2015 Eric Ren
#
# The 'divide and conqure' pattern of mergesort below.
# First let's divide our problem into smaller problems:
# [1,4,3,6,7,5,0,8]
# [1,4,3,6]       [7,5,0,8]
# [1,4]   [3,6]   [7,5]   [0,8]
# [1] [4] [3] [6] [7] [5] [0] [8]
#
# Now we merge the results:
# [1,4]   [3,6]   [5,7]   [0,8]
# [1,3,4,6]       [0,5,7,8]
# [0,1,3,4,5,6,78]
#
#
def mergesort(list)
  if list.length <= 1
    list
  end

  mid = list.length/2

  merge(mergesort(list[0,mid]),
        mergesort(list[mid, list.length]))

end

def merge(l1, l2)
  result = []
  while (not l1.empty?) and (not l2.empty?)
    if l1.first <= l2.first
      result.push(l1.shift)
    else
      result.push(l2.shift)
    end
  end

  if l1.empty?
    result.concat(l2)
  else
    result.concat(l1)
  end

  result
end

# Mergesort runs in O(nlogn) time. Why? Well lets take a look at
# the pattern of the recursive calls.
#
# Mergesort recursively calls itself twice each time the function is invoked.
#
#
#                      msort(n)
#                     /        \
#              msort(n/2)    msort(n/2)
#              /       \     /       \
#        msort(n/4)    ...  ...      ...
#        /
#      ...
#     /
#   msort(1)
#
#
# As you can see from the tree diagram above, mergesort recursively calls itself
# twice at each 'level'.  For each level, the problem sized gets halved for each
# function.  Since mergesort ends when the input size is 1, that means there are
# log2(n) levels from the first call all the way to the leaves.
#
# Of course the real work comes when the recursive calls 'comes back up' after
# executing the 'merge' function. Since the 'merge' function does at most a
# linear amount of work, and there are log(n) levels, the total runtime for
# mergesort is O(nlog(n)).
#
#
# As for space complexity, let's take a look at the arrays we are creating in
# our simple version of mergesort.  Although it looks like we are creating a
# lot of new arrays to store the sorted values, the new arrays are only used
# once by the caller function before the object is garbage collected.
#
# We only have at most three arrays at a time when performing the
# merge function.  The most amount of space the functon allocates is when we
# are merging the last two 'merged' arrays, so thats a total memory size:
# n/2 + n/2 + n, which is O(n).
#
# As for the stack trace, we only make at most log(n) calls at a time before
# function starts returning, so the space complexity is O(logn). Therefore the
# total space complexity for 'mergesort' is O(log(n) + n), or O(log(n)).
#
# For a more 'Formal' derivation, use the Master Theorem for the
# recurrence relation: T(n) = 2T(n/2) + O(n)
#
# Note: There are ways to do an in-place mergesort in order to obtain O(1)
# space complexity. Check out 'WikiSort' and the concept of 'Rotations'.


# quicksort
#
# This is probably the easiest/well-known implementation of quicksort
def qsort(a, l, h)
  if l < h
    p = Random.rand(l..h)
    pivot = a[p]
    a[p] = a[h]
    a[h] = pivot

    new_p = partition(a,l,h)
    qsort(a, l, new_p - 1)
    qsort(a, new_p + 1, h)
  end
end

def partition(a, low, high)
  pivot = a[high]
  i = low
  first_high = low

  while i < high
    if a[i] < pivot
      tmp = a[i]
      a[i] = a[first_high]
      a[first_high] = tmp

      first_high = first_high + 1
    end
    i = i + 1
  end

  tmp = a[first_high]
  a[first_high] = pivot
  a[high] = tmp

  return first_high
end
