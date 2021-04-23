from collections import defaultdict
from typing import Set

n, k = map(int, input().split())
parents = defaultdict(set)  # child -> parents of child
for i in range(n):
    m = list(map(int, input().split()))
    del m[0]
    for child in m:
        parents[child].add(i + 1)


for i in range(1, n + 1):
    ancestors = set()
    frontier = set([i])
    while len(frontier):
        x = frontier.pop()
        ancestors.add(x)
        frontier.update(parents[x] - ancestors)

    print(int(len(ancestors) > k))

"""
values = {x: set() for x in range(1, n + 1)}
def solve(i) -> Set[int]:
    if len(values[i]) > 0:
        return values[i]

    values[i].add(i)

    def solve_inner(ii):
        for j in parents[ii]:
            if j in values[ii]:
                continue
            values[ii].update(solve(j))
        return values[ii]

    return solve_inner(i)


for i in range(1, n + 1):
    if len(parents[i]) == 0:
        values[i] = 1

for i in range(1, n + 1):
    solve(i)

for i in range(1, n + 1):
    print(int(len(values[i]) > k))
"""
