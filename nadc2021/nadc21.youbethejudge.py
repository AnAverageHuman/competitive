#!/usr/bin/env python3
from math import sqrt
from sys import stdin


def is_prime(n: int) -> bool:
    if n <= 1 or (n > 2 and n % 2 == 0):
        return False
    return all(n % i for i in range(3, int(sqrt(n)) + 1, 2))


def main():
    try:
        numstr = stdin.read().split()
        if len(numstr) != 3:
            return 0
        if not all(x.isdigit() for x in numstr):
            return 0
        if any(x[0] == '0' for x in numstr):
            return 0
        a, b, c = map(int, numstr)
        return int(
            3 < a <= 10 ** 9
            and a % 2 == 0
            and b > 1
            and c > 1
            and is_prime(b)
            and is_prime(c)
            and a == b + c
        )
    except Exception as e:
        return 0


print(main())
