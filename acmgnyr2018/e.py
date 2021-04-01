#!/usr/bin/env python3
from math import copysign, remainder
from typing import List

P = int(input())


def solve(clocks: List[int], offsets: List[int]) -> int:
    possibilities = set((clocks[0] - o) % 720 for o in offsets)
    #possibilities = set(range(720))
    for guess in possibilities.copy():
        _clocks = set(clocks)
        for offset in offsets:
            print("a", offset, guess, offset + guess, _clocks)
            maybeclock = (guess + offset) % 720
            if maybeclock in _clocks:
                _clocks.remove(maybeclock)
            else:
                possibilities.remove(guess)
                break

    if len(possibilities) > 1:
        return len(possibilities)
    if len(possibilities) == 1:
        correct = possibilities.pop()
        hour = (correct // 60) % 12 or 12  # show 12 instead of 0
        minute = correct % 60
        return f"{hour}:{minute:02}"

    return "none"


for _ in range(P):
    K, N = map(int, input().split())
    clocks = [
        (h % 12) * 60 + int(copysign(m, h))
        for h, m in (map(int, x) for x in (input().split(":") for _ in range(N)))
    ]
    offsets = [
        int(remainder(h, 12) * 60 + copysign(m, h))
        for h, m in (map(float, x) for x in (input().split(":") for _ in range(N)))
    ]
    print(f"{K} {solve(clocks, offsets)}")
