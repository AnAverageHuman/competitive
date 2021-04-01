#!/usr/bin/env python3

P = int(input())
for _ in range(P):
    D = int(input())
    chars = input().rstrip('\r')
    N = int(input())
    X = map(int, input().split())

    pointer = 0
    print(D, end=" ")
    for x in X:
        pointer = (pointer + x) % len(chars)
        print(chars[pointer], end="")
    print()
