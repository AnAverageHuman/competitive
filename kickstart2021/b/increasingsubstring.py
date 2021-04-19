#!/usr/bin/env python3

T = int(input())
for case in range(1, T + 1):
    N = int(input())
    S = input()

    run = 1
    lens = [1]
    for i in range(1, len(S)):
        if S[i - 1] < S[i]:
            run += 1
        else:
            run = 1
        lens.append(run)

    print(f"Case #{case}: {' '.join(map(str, lens))}")
