from sympy.utilities.iterables import multiset_permutations
import numpy as np
import random

S = random.sample(range(2**15), 2**15//200)
for x in range(1,16):
    L = [1 if i<x else 0 for i in range(15)]
    L = np.array(L)
    i = 0
    #print(L, x)
    for p in multiset_permutations(L):
    
        if(i in S):
            for y in p:
                print(y, end="")
            print(" ", end="")
            print(format(x, '04b'))
        i+=1
