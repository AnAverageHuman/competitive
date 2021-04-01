from decimal import Decimal

ALPHABET = 'PQWERTYUIOJ#SZK*?F@D!HNM&LXGABCV'
INCREMENT = Decimal(0.0000152587890625)


def bin_to_dec(bin):
    total = 0
    for i in range(len(bin))[::-1]:
        total += 2**i * bin[-i - 1]
    return total


def dec_to_bin17(dec):
    dec = int(dec)
    if dec < 0:
        twos_comp = (dec ^ 0b11111111111111111) + 1
        arr = bin(twos_comp)
        arr = arr[arr.find('b') + 1:].zfill(17)
        return [int(i) for i in arr]
    else:
        return [int(i) for i in bin(dec)[2:].zfill(17)]


def find_solution(n, d):
    if d < -1 or d >= 1.0:
        print(f"{n} INVALID VALUE")
        return

    bits = dec_to_bin17(d / INCREMENT)

    opcode = ALPHABET[bin_to_dec(bits[0:5])]
    operand = bin_to_dec(bits[5:16])
    fullword = 'D' if bits[16] else 'F'
    print(f"{n} {opcode} {operand} {fullword}")


def main():
    p = int(input())
    for i in range(p):
        inp = input().split()
        n, d = int(inp[0]), Decimal(inp[1])
        find_solution(n, d)


if __name__ == '__main__':
    main()
