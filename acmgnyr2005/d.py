#!/usr/bin/env python3

from textwrap import wrap


def solve(g, b):
    if b == 0:
        return 'S' * g

    if g == 0:
        return 's' * b

    s = 's'
    cap = False
    for i in range(1, min(b, g)):
        if i % 2 == 1:
            s += i * 'H' + 'S'
            cap = True
        else:
            s += i * 'h' + 's'
            cap = False
    saves = s
    for i in range(1, abs(b - g) + 2):
        if (i % 2 == 1) != cap:
            s += min(b, g) * 'H' + ('s' if g <= b else 'S')
        else:
            s += min(b, g) * 'h' + ('s' if g <= b else 'S')

    s = s[:-1]
    saves = saves[::-1]

    if (b - g + 1) % 2 == 0:
        for c in saves:
            if c.isupper():
                s += c.lower()
            else:
                s += c.upper()
    else:
        s += saves

    #if g <= b:
    return s

    s2 = ''
    for c in s:
        if c.isupper():
            s2 += c.lower()
        else:
            s2 += c.upper()
    return s2


def main():
    n = int(input())

    for i in range(1, n + 1):
        p, g, b = [int(i) for i in input().split()]
        s = solve(g, b)
        print(f"{i} {len(s)}")
        print('\n'.join(wrap(s, width=50)))
        print()


if __name__ == '__main__':
    main()
