#!/usr/bin/env python3
from typing import Tuple


def do(p, q, N, M) -> str:
    def check(sum) -> Tuple[bool, int]:
        if (p * sum * (sum - 1)) % q != 0:
            return False, 0
        for x in range(1, (sum + 1) // 2 + 1):
            if 2 * x * (sum - x) == (p * sum * (sum - 1)) // q:
                return True, x

        return False, 0

    for sum in range(N, M + 1):
        boole, x = check(sum)
        if not boole:
            continue

        return f"{x} {sum - x}"

    return "NO SOLUTION"


p, q, N, M = map(int, input().split())

print(do(p, q, N, M))
