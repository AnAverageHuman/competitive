# written by Mathew Soto

n = int(input())


def getList(description, numOfPossibleVals):
    if description == "*":
        return [i for i in range(numOfPossibleVals)]

    listOfPossibleVals = description.split(",")
    finalList = []

    for index, val in enumerate(listOfPossibleVals):
        dashIndex = val.find("-")
        if dashIndex != -1:
            start, end = map(int, val.split("-"))
            finalList.extend(range(start, end + 1))
        else:
            finalList.append(int(val))

    return finalList


totalJobStarts = 0
timeTuples = set()

for _ in range(n):
    hours, minutes, seconds = input().split()

    # get list of values described by the input
    hoursList = getList(hours, 24)
    minutesList, secondsList = getList(minutes, 60), getList(seconds, 60)

    totalJobStarts += len(secondsList) * len(minutesList) * len(hoursList)

    for hour in hoursList:
        for minute in minutesList:
            for second in secondsList:
                timeTuples.add((hour, minute, second))


print(len(timeTuples))
print(totalJobStarts)
