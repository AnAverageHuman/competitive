from typing import List


def getEarliestIndex(arr, low, high, x):

    # Check base case
    if high - low <= 1:
        if arr[low] >= x:
            return low
        if arr[high] >= x:
            return high
        return -1


    mid = (high + low) // 2
    #print("BBBBB", arr[low], arr[mid], arr[high])

    if arr[high] == x:
        return high

    if arr[low] == x:
        return low

    if arr[mid] == x:
        return mid

    if arr[mid] > x:
        return getEarliestIndex(arr, low, mid, x)

    # Else the element can only be present in right subarray
    return getEarliestIndex(arr, mid, high, x)


def getLastIndex(arr, low, high, x):

    # Check base case
    if high - low <= 1:
        if arr[high].startswith(x):
            return high
        if arr[low].startswith(x):
            return low
        return -1

    mid = (high + low) // 2

    # print(arr[high], arr[mid], arr[low])

    if arr[mid][: len(x)] <= x:
        return getLastIndex(arr, mid, high, x)

    # Else the element can only be present in right subarray
    return getLastIndex(arr, low, mid, x)


def getNumOfQueries(suffixes: List[str], t: str, n: int) -> str:
    firstIndex = getEarliestIndex(suffixes, 0, len(suffixes) - 1, t)
    lastIndex = getLastIndex(suffixes, 0, len(suffixes) - 1, t)
    if firstIndex  == -1 or lastIndex == -1:
        return -1

    #print("FFFFFFFFFFFF", suffixes, firstIndex, lastIndex, t)
    # print(firstIndex, lastIndex, t)
    bla = suffixes[firstIndex : lastIndex + 1]
    bla.sort(key=len, reverse=True)

    if len(bla) < n:
        return -1

    return len(suffixes) - len(bla[n - 1]) + 1


s = input()

suffixes = [s[i:] for i in range(len(s))]
suffixes.sort()

q = int(input())

for _ in range(q):
    t, k = input().split()
    k = int(k)

    print(getNumOfQueries(suffixes, t, k))
