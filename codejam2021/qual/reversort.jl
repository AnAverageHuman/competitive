#!/usr/bin/env julia

function reversort!(case, N, L)
    c = @inbounds sum(1:N - 1) do i
        @views j = i + argmin(L[i:end]) - 1
        @views L[i:j] .= Iterators.reverse(L[i:j])
        j - i + 1
    end
    println("Case #$case: $c")
end

#function cost(case, N, L)
#    c = sum(((i, x),) -> abs(x - i + 1), enumerate(L))
#    println("Case #$case: $c")
#end

function main()
    T = parse(Int, readline())
    for case in 1:T
        N = parse(Int, readline())
        L = map(x -> parse(Int, x), split(readline()))
        reversort!(case, N, L)
    end
end


isinteractive() || main()
