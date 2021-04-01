#!/usr/bin/env julia

# not complete

function main()
    T = parse(Int, readline())
    P = parse(Int, readline())

    for case in 1:T
        corrects = BitMatrix(undef, 100, 10000)
        for i in 1:100
            corrects[i,:] .= map(x -> parse(Bool, x), split(readline()))
        end
        solve(P)
    end
end

isinteractive() || main()
