OFFSETS = (N = (0, 1), S = (0, -1), E = (1, 0), W = (-1, 0))

function solve(case, start, M)
    curr = start

    if sum(abs, curr) == 0
        println("Case #$(case): 0")
        return
    end

    for (i, x) in enumerate(M)
        curr .+= OFFSETS[Symbol(x)]
        if sum(abs, curr) <= i
            println("Case #$(case): $i")
            return
        end
    end

    if sum(abs, curr) < length(M) + 1
        println("Case #$(case): $(length(M))")
        return
    end

    println("Case #$(case): IMPOSSIBLE")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        _X, _Y, M = stdin |> readline |> split
        start = [parse(Int, _X), parse(Int, _Y)]
        solve(case, start, M)
    end
end

isinteractive() || main()
