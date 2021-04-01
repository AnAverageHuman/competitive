#!/usr/bin/env julia

function energy_makerecipe(result, recipes)
    for i in recipes[result]

    end
end

function solve(case, junctions, stones, recipes)
    energy = energy_makerecipe(1, recipes)
    println("Case #$case: $(energy > 10^12 ? -1 : energy)")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        N, M, S, R = parse.(Int, stdin |> readline |> split)

        # U -> (V, junction number) for each adjacent junction and vice versa
        junctions = Dict{Int,Vector{Int}}()
        for i in 1:M
            U, V = parse.(Int, stdin |> readline |> split)
            push!(get!(junctions, U, []), (V, i))
            push!(get!(junctions, V, []), (U, i))
        end

        # junction number -> stones
        stones = Dict{Int,Vector{Int}}()
        for i in 1:N
            C = parse.(Int, stdin |> readline |> split)
            map(x -> push!(get!(stones, C[x], []), i), 2:(C[1] + 1))
        end

        # resultant stone -> needed stones
        recipes = Dict{Int, Vector{Int}}()
        for _ in 1:R
            K = parse.(Int, stdin |> readline |> split)
            result = pop!(K)
            popfirst!(K)
            recipes[result] = K
        end

        solve(case, junctions, stones, recipes)
    end
end

isinteractive() || main()
