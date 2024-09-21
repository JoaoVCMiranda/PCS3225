from sympy.utilities.iterables import multiset_permutations
import numpy as np

for x in range(1,16):
    L = [1 if i<x else 0 for i in range(15)]
    L = np.array(L)
    #print(L, x)
    for p in multiset_permutations(L):
        for y in p:
            print(y, end="")
        print(" ", end="")
        print(format(x, '04b'))
