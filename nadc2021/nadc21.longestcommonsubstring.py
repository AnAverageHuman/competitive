def findstem(arr):
    s = min(arr, key=len)

    def checki(i):  # longest substring starting at i
        for j in range(i, len(s)):
            stem = s[i : j + 1]
            for str in arr:
                if stem not in str:
                    return j - i
        return len(s) - i

    return max(map(checki, range(len(s))))


n = int(input())
strings = [input() for _ in range(n)]
print(findstem(strings))
