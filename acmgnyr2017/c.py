#!/usr/bin/env python

OFFSETS = frozenset(
    (i, j) for i in range(-1, 2) for j in range(-1, 2) if i != 0 or j != 0
)


def isvalidpos(matrix, coord, n):
    x, y = coord
    if not matrix or matrix[x][y] != 0:
        return False

    for offset in OFFSETS:
        xx, yy = (a + b for a, b in zip(coord, offset))
        if 0 <= xx < len(matrix) and 0 <= yy < len(matrix[xx]) and matrix[xx][yy] == n:
            return False

    #print("HERE4")
    #for row in matrix:
        #print(*row)
    #print()
    return True


def nextval(n, matrix, region):
    d = { matrix[x][y]: (x, y) for x, y in region }
    while n in d.keys():
        region.remove(d[n])
        n += 1
    return n


# region: set of tuples (pairs)
def insert(matrix, region, n):
    if len(region) == 0:
        yield matrix

    for coord in region.copy():
        if isvalidpos(matrix, coord, n):
            x, y = coord
            matrix[x][y] = n
            region.remove(coord)

            yield from insert(matrix, region, nextval(n + 1, matrix, region))
            region.add(coord)
            matrix[x][y] = 0

    return False


# regions: k: ints, v: sets (a region) of tuples (pairs)
def solve(matrix, regions):
    if len(regions) == 0:
        return True

    for region in regions:
        _matrix = matrix
        for sol in insert(matrix, region, nextval(1, matrix, region)):
            #print("HERE")
            #print(sol)
            #print("HERE2")
            regions.remove(region)
            if solve(sol, regions):
                return True
            regions.append(region)
            matrix = _matrix

    #print("leaving")
    return False


P = int(input())
for _ in range(P):
    K, R, C = map(int, input().split())
    matrix = []
    for _ in range(R):
        matrix.append([0 if x == "-" else int(x) for x in input().split()])

    numregions = int(input())
    regions = []
    for _ in range(numregions):
        line = input().split()
        del line[0]  # N
        regions.append(set(tuple(int(z) - 1 for z in i[1:-1].split(",")) for i in line))

    regions = sorted(regions, key=len)
    solve(matrix, regions)

    print(K)
    for row in matrix:
        print(*row)
