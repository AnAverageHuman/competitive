#!/usr/bin/env python3
from math import sqrt

Ns = list(map(float, input().split()))
avg = sum(Ns) / len(Ns)
s = sqrt(sum((x - avg) ** 2 for x in Ns) / (len(Ns) - 1))
print("COMFY" if s <= 1 else "NOT COMFY")
