#!/usr/bin/env python3

from math import sqrt, sin, cos, atan


def myround(n):
    if int(2 * n) == 2 * int(n):
        return int(n)

    return int(n) + 1


def dist(x, y):
    return sqrt((x[0] - y[0]) ** 2 + (x[1] - y[1]) ** 2)


def foo(p1, p2):
    m = ((p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2)
    d1 = dist(p1, m)
    dlen = sqrt(4 - d1 ** 2)
    n = (p2[1] - p1[1]) / (p2[0] - p1[0])
    d = (-1 * n / sqrt(1 + n ** 2) * dlen, 1 / sqrt(1 + n ** 2) * dlen)
    #t = atan(n)
    #d = (-1 * sin(t) * dlen, cos(t) * dlen)
    return (m[0] + d[0], m[1] + d[1])


def solve(n, l):
    arr = [[0] * n] * n
    for i in range(n):
        arr[0][i] = (l[i], 1)
    for i in range(1, n):
        for j in range(n - i):
            arr[i][j] = foo(arr[i - 1][j], arr[i - 1][j + 1])

    return arr[-1][0]
    return ((l[0] + l[-1]) / 2, arr[-1][0][1])


def main():
    n = int(input())
    for i in range(1, n + 1):
        line = [float(i) for i in input().split()]
        k = int(line[0])
        del line[0]

        x, y = solve(k, line)
        print(f"{i}: {x:.4f} {y:.4f}")


if __name__ == '__main__':
    main()
