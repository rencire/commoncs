require 'set'

##
# Desribe the behaviour of the method
#
# ==== Parameters
#
# * +s+ - Set of objects we want to find subsets of
# * +k+ - Size of each subset we want to return
#
# Returns an Array of SortedSets, with each set corresponding to a subset of size k.
#
def gen_k_subset(s,k)
  if s.size == 0 or k > s.size
    return []
  end

  if k == 1
    return s.map {|n| SortedSet.new([n])}
  end


  rest = s - [s.first]
  result = gen_k_subset(rest, k - 1)

  result = result.map do |subset|
    subset.add(s.first)
  end

  return result.concat(gen_k_subset(rest, k))


end

puts gen_k_subset(Set.new(['a','b','c', 'd', 'e']),2).inspect

# puts gen_k_subset(Set.new(['a','b','c']),1).inspect

