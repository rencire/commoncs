import math

def sieve(x):
    numbers = [True]*(x+1)
    for divisor in range(2, int(math.sqrt(x)) + 1, 1):
        if numbers[divisor]:
            for n in range(2 * divisor, x+1, divisor):
                numbers[n] = False

    for n in range(2,x+1,1):
        if numbers[n]:
            print(n)

            
