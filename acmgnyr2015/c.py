#!/usr/bin/env python3


def fib(n):
    if n in d:
        return d[n]

    if n % 2 == 0:
        k = n // 2
        j = fib(k)
        d[n] = int((j * (2 * fib(k + 1) - j)) % 1e9)
    else:
        k = (n - 1) // 2
        d[n] = int((fib(k + 1) ** 2 + fib(k) ** 2) % 1e9)
    return d[n]


def solve(K, Y):
    ans = fib(Y)

    for i in sorted(d):
        print(i, d[i])

    print(f"{K} {ans}")


def main():
    P = int(input())
    for _ in range(P):
        global d
        d = {1: 1, 2: 1}
        K, Y = [int(i) for i in input().split()]
        solve(K, Y)


if __name__ == '__main__':
    main()
