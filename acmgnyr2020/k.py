#!/usr/bin/env python3


def foo(a: int, b: int) -> int:
    ans = 1
    for i in range(b // 30):
        ans *= 2 ** 30
        ans %= 998244353

    ans *= 2 ** (b % 30)
    return (ans - a) % 998244353


p, q = map(int, input().split())


a = p
b = q
aa = (0, 0)
bb = (1, 0)
while a != 1 or b != 1:
    if a < b:
        b -= a
        aa = (aa[0], aa[1] + 1)
        bb = (bb[0], bb[1] + 1)
        bb = (2 * bb[0] - aa[0], bb[1])  # reflect across aa
    else:
        a -= b
        bb = (bb[0], bb[1] + 1)
        aa = (aa[0], aa[1] + 1)
        aa = (2 * aa[0] - bb[0], aa[1])  # reflect across bb

k = foo(*aa)
print(k)
