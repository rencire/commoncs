

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

