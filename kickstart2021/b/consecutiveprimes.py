#!/usr/bin/env python3
from itertools import count
from math import sqrt


def is_prime(n: int) -> bool:
    if n <= 1 or (n > 2 and n % 2 == 0):
        return False
    return all(n % i for i in range(3, int(sqrt(n)) + 1, 2))


def slightly_larger(n: int) -> int:
    return next(filter(is_prime, count(n + 1)))


def largest_smaller(n: int) -> int:
    return next(filter(is_prime, range(n - 1, 1, -1)))


T = int(input())
for case in range(1, T + 1):
    Z = int(input())
    a = slightly_larger(int(sqrt(Z)) + 1)
    b = largest_smaller(a)
    while a * b > Z:
        a = b
        b = largest_smaller(a)

    print(f"Case #{case}: {a * b}")
