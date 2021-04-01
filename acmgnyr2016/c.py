#!/usr/bin/env python
from functools import lru_cache
from math import log

P = int(input())

for _ in range(P):
    K, m, n = map(int, input().split())

    @lru_cache(maxsize=None)
    def get(n, b):
        if b <= 1:
            return n // m + 1

        step = m ** b
        return sum(get(n - step * i, b - 1) for i in range(n // step + 1))

    print(f"{K} {get(n, int(log(n, m)))}")
