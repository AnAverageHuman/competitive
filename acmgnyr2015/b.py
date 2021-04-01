#!/usr/bin/env python3
from math import ceil, floor
from functools import cache

P = int(input())
for _ in range(P):
    K, S = map(int, input().split())

    #lookup = {}
    @cache
    # number of ways to climb n stairs with 1 leg and k 2-stair steps
    def get(n, k):
        if k == 1:
            return max(0, n - 1)
        if n <= 1:
            return 0
        #if (n, k) in lookup.keys():
        #    return lookup[(n, k)]

        return get(n - 1, k) + get(n - 2, k - 1)
        #lookup[(n, k)] = strides
        #return strides

    leg = S // 2  # one leg
    ans = sum(get(leg, k) ** 2 for k in range(ceil(leg / 3), floor(leg / 2) + 1))
    print(f"{K} {ans}")
