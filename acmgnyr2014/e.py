#!/usr/bin/env python

P = int(input())

for _ in range(P):
    K, N = map(int, input().split())

    b = []
    while N > 0:
        empty = len(b)
        for (i, x) in enumerate(b):
            if x == 0:
                empty = i
                break

        for i in range(empty):
            b[i] -= 1

        if empty == len(b):
            b.append(empty + 1)
        else:
            b[empty] = empty + 1
        N -= 1

    print(f"{K} {len(b)}")

    for (i, x) in enumerate(b):
        print(x, end="\n" if i % 10 == 9 else " ")
    if len(b) % 10:
        print()
