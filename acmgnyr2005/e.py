#!/usr/bin/env python3


def solve(string):
    array = [0 for i in range(32768)]
    ptr = 0
    brackets = 0

    i = -1
    while i < len(string) - 1:
        i += 1
        c = string[i]

        if c == '>':
            ptr = (ptr + 1) % 32768
        if c == '<':
            ptr = (ptr - 1) % 32768
        if c == '+':
            array[ptr] = (array[ptr] + 1) % 256
        if c == '-':
            array[ptr] = (array[ptr] - 1) % 256
        if c == '.':
            print(chr(array[ptr]), end='')
        if c == '[' and array[ptr] == 0:
            brackets = 1
            while brackets > 0:
                i += 1
                if string[i:i + 3] == 'end':
                    print("COMPILE ERROR")
                    return

                c = string[i]

                if c == '[':
                    brackets += 1
                if c == ']':
                    brackets -= 1
        if c == ']' and array[ptr] != 0:
            brackets = 1
            while brackets > 0:
                if i == 0:
                    print("COMPILE ERROR")
                    return

                i -= 1
                c = string[i]
                if c == '[':
                    brackets -= 1
                if c == ']':
                    brackets += 1
    print()

def main():
    n = int(input())
    for i in range(1, n + 1):
        string = ""
        line = ''
        while 'end' not in line:
            line = input()
            if '%' in line:
                line = line[:line.find('%')]
            string += line
        count = 0
        for c in string:
            if c == '[':
                count += 1
            if c == ']':
                count -= 1
        print(f"PROGRAM #{i}:")
        if count:
            print("COMPILE ERROR")
        else:
            solve(string)


if __name__ == '__main__':
    main()
