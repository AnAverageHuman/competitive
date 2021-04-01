#!/usr/bin/env python3

dict = {i: (i ** 3) % 10 for i in range(10)}
reversedict = {dict[k]: k for k in dict}


def solve(s):
    s = s[::-1]
    temp = str(reversedict[int(s[0])])
    for i in range(2, len(s) + 1):
        num = int(temp)
        for x in range(10):
            ten = 10 ** (i - 1)
            if (((num ** 3) + 3 * ten * (num ** 2) * x) // ten) % 10 == int(s[i - 1]):
                temp = str(x) + temp
                continue
    return int(temp)


def main():
    n = int(input())
    for i in range(1, n + 1):
        k = str(int(input()))
        print(solve(k))



if __name__ == '__main__':
    main()
