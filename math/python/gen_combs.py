"""
Generate combinations
"""
import copy

def gen_combs(input_nums):
  combinations = [set()];
  
  for element in input_nums:
    new_combs = copy.deepcopy(combinations)
    for c in new_combs:
      c.add(element)
      
    combinations.extend(new_combs)
  
  return combinations



def gen_combs2(input_nums):
  combinations = [set()];
  
  for element in input_nums:
    new_combs = [ set([element]) | c for c in combinations]
    combinations.extend(new_combs)
  
  return combinations
  
  
def gen_combs3(input_nums):
  combinations = [set()];

  for element in input_nums:
    combinations.extend([ set([element]) | c for c in combinations])
  
  return combinations  
  
  
  
# recursive
# - reducing the input in subproblems
def gen_combs_driver(input_nums):
  return gen_combs4(input_nums, [set()]) 
  
def gen_combs4(input_nums, combinations):
  if len(input_nums) < 1:
    return combinations
  else:
    element = input_nums.pop(0)
    combinations.extend([ set([element]) | c for c in combinations])
    gen_combs4(input_nums, combinations)
    
    

# recursive plus immutable data structures (more functional)
def gen_combs_driver2(input_nums):
  return gen_combs5(input_nums, [set()])
  
def gen_combs5(input_nums, combinations):
  if len(input_nums) < 1:
    return combinations
  else:
    element = input_nums[0]
    new_combs = [ set([element]) | c for c in combinations])
    gen_combs5(input_nums[1:], new_combs + combinations)
     

# functional w/ helper
def gen_combs_driver2(input_nums):
  return gen_combs6(input_nums, [set()])
  
def gen_combs6(input_nums, combinations):
  if len(input_nums) < 1:
    return combinations
  else:
    gen_combs6(
      input_nums[1:], 
      gen_next_combs(input_nums[0], combinations) + combinations
    )
    
def gen_next_combs(element, combinations)
    return [ set( [ element ] ) | c for c in combinations]
    
    
# can even go back to using the imported copy module
import copy

def gen_next_combs2(element, combinations)
  next_combs = copy.deepcopy(combinations)
  for c in next_combs:
    c.add(element)
  return next_combs
  
