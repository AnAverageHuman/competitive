#!/usr/bin/env python3

NT, NP, NS, NR = map(int, input().split())

# team -> [int]
times = [[0] * NP for t in range(NT + 1)]
# team -> [int]
penalties = [[0] * NP for t in range(1, NT + 1)]
# team -> [bool]
correct = [[False] * NP for t in range(1, NT + 1)]

for i in range(NS):
    T, P, t, D = map(int, input().split())
    T -= 1
    P -= 1
    if t >= 300:
        continue
    if correct[T][P]:  # already correct, no update
        continue
    times[T][P] = t
    if D:  # correct
        correct[T][P] = True
    else:  # wrong answer
        penalties[T][P] += 1


def getconsumed(team, i):
    return times[team][i] + 20 * penalties[team][i]


def key(team):
    bigtimes = sorted(
        ((times[team][i], -i) for i in range(NP) if correct[team][i]), reverse=True
    )
    return (
        sum(correct[team]),  # problems correct
        -sum(
            getconsumed(team, i) for i in range(NP) if correct[team][i]
        ),  # total time consumed (with penalty)
        *(
            -getconsumed(team, -bt[1]) for bt in bigtimes
        ),  # times consumed sorted by times finished
        -team,
    )


rankings = sorted(list(range(NT)), key=key, reverse=True)
standings = [
    [
        0,
        i,
        sum(correct[i]),
        sum(getconsumed(i, p) for p in range(NP) if correct[i][p]),
    ]
    for i in rankings
]

current = 1
currentlen = 1
for i in range(len(standings)):
    standings[i][0] = current
    if i == len(standings) - 1:
        continue
    if key(standings[i][1])[:-1] == key(standings[i + 1][1])[:-1]:
        currentlen += 1
    else:
        current += currentlen
        currentlen = 1

for s in standings:
    if s[0] > NR:
        break
    print(f"{s[0]: <4}{s[1]+1: <4}{s[2]: >3}{s[3]: >5}")
