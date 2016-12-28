# import random 
# def sol1(n):
#     solution = [] 
#
#     col = 0
#     while(len(solution) < n):
#         for i in range(n): 
#             if not under_attack(i,solution):
#                 solution.append[pos]
#             else:


def bt(n, sol, solutions, choices):
    if len(sol) == n:
        solutions.add(sol)
    elif len(sol) < n and len(choices) == 0:
        return 
    # len(sol) should not be > n, so ignore this case
    else:
        for i in choices:
            sol.append(i)
            next_choices = get_next_queen_choices(sol)
            bt(n, sol, solutions, next_choices)

def get_next_queen_choices(current_places):

    






    


        

def test():
    for i in range(4):
        print(i)

    print(i)

test()
    


