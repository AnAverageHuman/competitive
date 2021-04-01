#!/usr/bin/env python
nrows, ncols = map(int, input().split())
board = []

for i in range(nrows):
    board.append(list(map(int, input().split())))

CORNER = [(-1, -1), (-1, 1), (1, -1), (1, 1)]
EDGE = [(-1, 0), (0, 1), (0, -1), (1, 0)]

edge = 0
vertex = 0
for r in range(nrows):
    for c in range(ncols):
        if board[r][c] == 0:
            continue
        for o in EDGE:
            rr, cc = r + o[0], c + o[1]
            if 0 <= rr < nrows and 0 <= cc < ncols and board[rr][cc]:
                edge += 1

        for o in CORNER:
            rr, cc = r + o[0], c + o[1]
            if 0 <= rr < nrows and 0 <= cc < ncols and board[rr][cc]:
                vertex += 1

print(f"{edge // 2} {(edge + vertex) // 2}")
