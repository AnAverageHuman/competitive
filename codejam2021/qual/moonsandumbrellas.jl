#!/usr/bin/env julia

function cost(X, Y, S) 
    c = 0
    for i in eachindex(S)
        i == firstindex(S) && continue
        S[i - 1] == 'C' && S[i] == 'J' && (c += X)
        S[i - 1] == 'J' && S[i] == 'C' && (c += Y)
    end
    c
end

Base.isless(::Nothing, ::Nothing) = true
Base.isless(::Nothing, x) = false
Base.isless(x, ::Nothing) = true

function solve!(X, Y, S, i)
    c = cost(X, Y, S)
    function recurse!(ii, depth)
        _ii = findnext(==('?'), S, ii)
        (_ii === nothing || depth == 0) && return S, cost(X, Y, S)
        save = copy(S)
        S[_ii] = 'C'
        Scand1, Scost1 = recurse!(_ii, depth - 1)
        S = save
        S[_ii] = 'J'
        Scand2, Scost2 = recurse!(_ii, depth - 1)
        Scost1 < Scost2 ? (Scand1, Scost1) : (Scand2, Scost2)
    end

    while i !== nothing
        S, c = recurse!(i, min(3, findnext(==('C'), S, i), findnext(==('J'), S, i)))
        i = findnext(==('?'), S, i)
    end
    S, c
end

function solve(case, X, Y, S)
    S, c = solve!(X, Y, S, firstindex(S))
    @assert findfirst(==('?'), S) === nothing
    println("Case #$case: $c")
end

function main()
    T = parse(Int, readline())
    for case in 1:T
        _X, _Y, _S = split(readline())
        X = parse(Int, _X)
        Y = parse(Int, _Y)
        S = Vector{Char}(_S)
        solve(case, X, Y, S)
    end
end

isinteractive() || main()
