#!/usr/bin/env julia

function solve(case, N, A, B, C)
    filler = N - A - B + C
    if filler < 0
        println("Case #$case: IMPOSSIBLE")
        return
    end

    str = []
    if A == 1
        append!(str, Vector((N - A + C):N))
        append!(str, repeat([N], C - 1))
        append!(str, repeat([1], filler))
        append!(str, Vector((N - 1):-1:(N - B + C)))
    else
        append!(str, Vector((N - A + C):(N - 1)))
        append!(str, repeat([N], C - 1))
        append!(str, repeat([1], filler))
        append!(str, Vector(N:-1:(N - B + C)))
    end
    println("Case #$case: $(join(str, " "))")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        N, A, B, C = parse.(Int, stdin |> readline |> split)
        solve(case, N, A, B, C)
    end
end

isinteractive() || main()
