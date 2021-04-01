#!/usr/bin/env python3

P = int(input())

for _ in range(P):
    K, b, n = map(int, input().split())
    ssd = 0
    while n > 0:
        digit = n % b
        n //= b
        ssd += digit * digit
    print(f"{K} {ssd}")
