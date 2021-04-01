#!/usr/bin/env julia

function solve(case, N, A)
    pattern = A[2] - A[1]
    longest = 2
    current = 2
    for i in 3:N
        diff = A[i] - A[i - 1]
        if diff == pattern
            current += 1
        else
            pattern = diff
            longest = max(current, longest)
            current = 2
        end
    end
    longest = max(current, longest)
    println("Case #$case: $longest")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        N = parse(Int, readline(stdin))
        A = parse.(Int, stdin |> readline |> split)
        solve(case, N, A)
    end
end

isinteractive() || main()
