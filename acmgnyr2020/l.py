#!/usr/bin/env python3

def do(s: str) -> str:
    last = {} # last index seen
    lastlast = set() # in here if seen twice
    for (i, x) in enumerate(s):
        if x in lastlast:
            return "NO"

        if x in last:
            lastlast.add(x)
            if (i - last[x]) % 2 == 0:
                return "NO"
        else:
            last[x] = i

    return "YES"


s = input()
print(do(s))
