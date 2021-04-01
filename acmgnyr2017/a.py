#!/usr/bin/env python3

P = int(input())

for _ in range(P):
    K, N = map(int, input().split())
    s = sum(range(2, N + 2))
    # s = (1 + N) * N // 2 + N
    print(f"{K} {int(s)}")
