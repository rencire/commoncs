# Eric Ren 2016

## Max-min Fairness algorithm
#
#
# R = resources
# C = list of consumers, each demanding a certain amount of resources
#
# Repeat until no more resources left:
#   c = consumer with lowest resource demand from C
#   if c's resource demand > R/|C|
#     allocate R/|C| to consumer c
#   else
#     allocate c's resource demand
#   end
#   remove c from C
#   remove the allocated resource from R
#


total_res = 15
Consumer = Struct.new(:id, :demand, :allocated, :order)

c_list = Array.new(5).map.with_index do | _, i |
  Consumer.new(i, 1 + rand(20))
end

# consumers - Array of consumers
# resource - Fixnum
# order - Fixnum. Used to sort printed output
def max_min_fairness(consumers, resource, order)
  return if consumers.empty? or resource <= 0

  equal_share = resource/consumers.length

  consumer = consumers.min_by {|c| c.demand}
  consumer.order = order

  if consumer.demand > equal_share
    consumer.allocated = equal_share
    max_min_fairness(consumers.select {|c| c.allocated.nil?}, resource - consumer.allocated, order + 1)
  else
    consumer.allocated = consumer.demand
    max_min_fairness(consumers.select {|c| c.allocated.nil?}, resource - consumer.allocated, order + 1)
  end
end


# Output
max_min_fairness(c_list, total_res, 0)
ap c_list.sort_by {|c| c.order}

# Invariant 1: all 'allocated' must sum up to total_res
allocated = c_list.inject(0) do |sum, customer|
  sum + customer.allocated
end

puts "Total Resource == Sum of allocated?: #{total_res == allocated}"

# Invariant 2: 'allocated' can not be more than 'demand'
all_no_more_than_demand = c_list.inject do |res, c|
  res and c.allocated < c.demand
end

puts "For each consumer: allocated <= demand? #{all_no_more_than_demand}"







##
