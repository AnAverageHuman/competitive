#!/usr/bin/env python3


def days_per_month(year):
    leap = False

    if year % 400 == 0:
        leap = True
    elif year % 100 == 0:
        leap = False
    elif year % 4 == 0:
        leap = True

    return [0, 31, 29 if leap else 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]


def distance(a, b):
    if a['m'] == b['m']:
        return a['d'] - b['d']

    year = a['y']
    x = False
    if b['m'] > a['m']:
        a, b = b, a
        x = True

    if a['m'] - b['m'] == 11:
        return (-1 if x else 1) * (31 - a['d'] + b['d'])

    if a['m'] - b['m'] > 1:
        return 20

    return (-1 if x else 1) * (days_per_month(year)[b['m']] - b['d'] + a['d'])


def main():
    n = int(input())

    for i in range(1, n + 1):
        a, b = input().split()
        a = [int(i) for i in a.split('/')]
        a = {'m': a[0], 'd': a[1], 'y': a[2]}
        b = [int(i) for i in b.split('/')]
        b = {'m': b[0], 'd': b[1]}

        n = distance(a, b)
        before = n > 0

        if n == 0:
            print(f"{i} SAME DAY")
            continue

        if abs(n) > 7:
            print(f"{i} OUT OF RANGE")
            continue

        x = 'PRIOR' if before else 'AFTER'
        year = a['y']
        if a['m'] == 12 and b['m'] == 1:
            year += 1
            x = 'AFTER'
        elif a['m'] == 1 and b['m'] == 12:
            year -= 1
            x = 'PRIOR'

        y = 'DAYS' if abs(n) > 1 else 'DAY'
        print(f"{i} {b['m']}/{b['d']}/{year} IS {abs(n)} {y} {x}")


if __name__ == '__main__':
    main()
