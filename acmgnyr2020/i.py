#!/usr/bin/env python3
from collections import defaultdict
from sys import exit

prog = input()

stack = []
heap = defaultdict(int)
labels = {}
i = 0
inputbuf = ""


def read_inst() -> str:
    global i
    s = prog[i : i + 3]
    i += 3
    return s


def read_bit() -> int:
    global i
    b = prog[i]
    i += 1
    return int(b)


def read_num() -> int:
    global i
    ii = i + 1
    while prog[ii] != "2":
        ii += 1
    n = prog[i:ii]
    i = ii + 1
    return int(n, base=2)


def input_chr() -> str:
    global inputbuf
    if inputbuf == "":
        inputbuf = input()
    c = inputbuf[0]
    inputbuf = inputbuf[1:]
    return c


def input_int() -> int:
    global inputbuf
    if inputbuf == "":
        inputbuf = input()
    j = 1
    while inputbuf[j] != "2":
        j += 1
    s = inputbuf[:j]
    inputbuf = inputbuf[j:]
    return s


def execute(inst: str):
    global i
    if inst == "000":
        stack.append(read_num())
    elif inst == "001":
        stack.append(-1 * read_num())
    elif inst == "020":
        stack.append(stack[-1])
    elif inst == "021":
        stack[-1], stack[-2] = stack[-2], stack[-1]
    elif inst == "100":
        S1 = stack.pop()
        S2 = stack.pop()
        b = read_bit()
        if b == 0:
            stack.append(S1 + S2)
        elif b == 1:
            stack.append(S2 + S1)
        elif b == 2:
            stack.append(S2 * S1)
        else:
            raise RuntimeError()
    elif inst == "101":
        S1 = stack.pop()
        S2 = stack.pop()
        b = read_bit()
        if b == 0:
            if S1 == 0:
                print(inst)
                raise RuntimeError()
            stack.append(S2 // S1)
        elif b == 1:
            if S1 == 0:
                print(inst)
                raise RuntimeError()
            stack.append(S2 % S1)
    elif inst == "110":
        S1 = stack.pop()
        S2 = stack.pop()
        heap[S2] = S1
    elif inst == "111":
        S1 = stack.pop()
        stack.append(heap[S1])
    elif inst == "200":
        mark = read_num()
        if mark in labels:
            print(inst)
            raise RuntimeError()
        labels[mark] = i
    elif inst == "201":
        _i = i
        do_routine(i)
        i = _i
    elif inst == "202":
        mark = read_num()
        if mark not in labels:
            print(inst)
            raise RuntimeError()
        i = labels[mark]
    elif inst == "210":
        mark = read_num()
        S1 = stack.pop()
        print(mark)
        print(labels)
        if mark not in labels:
            print(inst)
            raise RuntimeError()
        if S1 == 0:
            i = labels[mark]
    elif inst == "211":
        mark = read_num()
        S1 = stack.pop()
        if mark not in labels:
            print(inst)
            raise RuntimeError()
        if S1 < 0:
            i = labels[mark]
    elif inst == "212":
        return "ZZ"
    elif inst == "222":
        exit(0)
    elif inst == "120":
        b = read_bit()
        S1 = stack.pop()
        if b == 0:
            print(chr(S1), end="")
        elif b == 1:
            print(S1)
    elif inst == "121":
        b = read_bit()
        S1 = stack.pop()
        if b == 0:
            c = input_chr()
            stack.append(c)
        elif b == 1:
            c = input_int()
            stack.append(c)
    else:
        print(inst)
        raise RuntimeError()


def do_routine(i: int):
    while True:
        if "ZZ" == execute(read_inst()):
            break


try:
    do_routine(0)
except RuntimeError:
    print("RUN-TIME ERROR")
