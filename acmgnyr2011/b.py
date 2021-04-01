#!/usr/bin/env python

P = int(input())
for _ in range(P):
    N, n, m = [int(i) for i in input().split()]
    print(f"{N} {(n - m) * m + 1}")
