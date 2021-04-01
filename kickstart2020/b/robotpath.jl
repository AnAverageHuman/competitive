# Wrong Answer

const offsets = (N = (0, -1), S = (0, 1), E = (1, 0), W = (-1, 0))

function solveRec(X, i)
    multiplier = X[i]
    offset = [0, 0]
    i += 2 # skip number and open paren

    while true
        if X[i] == ')'
            offset .*= parse(Int, multiplier)
            return offset, i
        end

        if isdigit(X[i])
            suboffset, close = solveRec(X, i)
            i = close + 1
            offset .+= suboffset
        else
            offset .+= offsets[Symbol(X[i])]
            i += 1
        end
    end
end

function solve(case, X)
    coords = [1, 1]

    i = firstindex(X)
    while i <= lastindex(X)
        if isdigit(X[i])
            offset, close = solveRec(X, i)
            coords .+= offset
            i = close + 1
        else
            coords .+= offsets[Symbol(X[i])]
            i += 1
        end
    end

    x, y = mod1.(coords, Int(1e9))
    println("Case #$(case): $x $y")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        path = readline(stdin)
        solve(case, path)
    end
end

isinteractive() || main()
