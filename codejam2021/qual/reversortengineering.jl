#!/usr/bin/env julia

# not the correct approach

function solve(case, N, C)
    N - 1 <= C <= sum(1:N) - Int(iseven(N)) || (println("Case #$case: IMPOSSIBLE"); return)
    S = collect(1:N)

    i = lastindex(S) - 1
    while C > 0
        c = lastindex(S) - i + 1
        if c <= C - i
            #@info C i c
            @views S[i:end] .= Iterators.reverse(S[i:end])
            C -= c
        else
            C -= 1
        end
        i -= 1
    end
    println("Case #$case: $(join(S, ' '))")
end

function main()
    T = parse(Int, readline())
    for case in 1:T
        N, C = map(x -> parse(Int, x), split(readline()))
        solve(case, N, C)
    end
end

isinteractive() || main()
