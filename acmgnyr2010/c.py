#!/usr/bin/env python3
from textwrap import wrap
from typing import List


def encode(num: str) -> str:
    return f"{num:0>2X}"  # to capital hex form, 0-padded 2 chars


def do_pass(bytes: List[str]) -> List[str]:
    i = 0
    while i < len(bytes):
        if i + 1 >= len(bytes):
            return bytes[:i] + ["00", bytes[-1]]
        if i + 2 >= len(bytes):
            return bytes[:i] + ["01", bytes[-2], bytes[-1]]

        if bytes[i] == bytes[i + 1] == bytes[i + 2]:
            # need to compress
            count_3 = 0
            while (
                count_3 < 127
                and i + count_3 + 3 < len(bytes)
                and bytes[i] == bytes[i + count_3 + 3]
            ):
                count_3 += 1
            bytes = (
                bytes[:i]
                + [encode(128 + count_3)]  # high order bit in 8-bit byte: 128
                + [bytes[i]]
                + bytes[i + count_3 + 3 :]
            )
            i += 2
        else:
            # not a run
            nonrun_1 = 0
            inbounds = True
            while inbounds:
                nonrun_1 += 1
                inbounds = nonrun_1 < 128 and i + nonrun_1 < len(bytes)
                if i + nonrun_1 + 2 < len(bytes):
                    inbounds &= (
                        not bytes[i + nonrun_1]
                        == bytes[i + nonrun_1 + 1]
                        == bytes[i + nonrun_1 + 2]
                    )

            nonrun_1 -= 1
            bytes = bytes[:i] + [encode(nonrun_1)] + bytes[i:]
            i += nonrun_1 + 2
        #print(bytes)
        #print(i)

    return bytes


P = int(input())
for _ in range(P):
    K, B = map(int, input().split())
    buf = ""
    while len(buf) < B * 2:
        buf += input().strip()
    bytes = wrap(buf, 2)  # list of two characters each
    out = do_pass(bytes)
    print(f"{K} {len(out)}")
    for line in wrap("".join(out), 80):
        print(line)
