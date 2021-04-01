#!/usr/bin/env python3

from math import sqrt


def foo(x, n):
    if n % 2 == 1:
        return x % n == 0

    return (2 * x) % n == 0 and (2 * x / n) % 2 == 1 and x / n + 0.5 - n / 2 > 0


def solve(x):
    count = 0

    for n in range(2, int(sqrt(2 * x) + 1) + 1):
        if foo(x, n):
            count += 1

    return count


def main():
    n = int(input())

    for i in range(1, n + 1):
        k, p = [int(j) for j in input().split()]
        print(f"{k} {solve(p)}")


if __name__ == '__main__':
    main()
