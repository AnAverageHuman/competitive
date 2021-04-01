#!/usr/bin/env python3
from math import ceil

P = int(input())

for _ in range(P):
    K, N = map(int, input().split())

    nvalid = 0
    for k in range(ceil(N / 3), (N // 2) + 1):
        nvalid += (3 * k) - N
    if N % 3 == 0:  # equilateral triangle
        nvalid += 1

    print(f"{K} {nvalid}")
