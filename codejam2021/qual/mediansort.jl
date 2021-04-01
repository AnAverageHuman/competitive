#!/usr/bin/env julia

# uses too many queries for testset 3

function solve(N, Q)
    function ask(query)
        Q < 0 && exit()
        println(join(query, ' '))
        res = parse(Int, readline())
        Q -= 1
        res == -1 && exit()
        res
    end

    # bootstrap so we have 3 to begin with
    query = [1, 2, 3]
    mid = ask(query)
    popat!(query, mid)
    S = [query[1], mid, query[2]]

    function bisect(val, left, right)
        left == right && return insert!(S, left, val)

        if right - left == 1
            mid = ask((S[left], val, S[right]))
            mid == S[left] && return insert!(S, left, val)
            mid == S[right] && return insert!(S, right + 1, val)
            return insert!(S, right, val)
        end

        mid = (left + right) ÷ 2
        #@info val left S[left] right S[right] mid S[mid]

        lefttomid = ask((S[left], val, S[mid]))
        lefttomid == S[left] && return insert!(S, left, val)
        lefttomid == val && return bisect(val, left, mid)
        midtoright = ask((S[mid], val, S[right]))
        midtoright == S[right]  && return insert!(S, right + 1, val)
        midtoright == mid && insert!(S, mid, val)
        bisect(val, mid + 1, right)
    end

    for val in 4:N
        bisect(val, firstindex(S), lastindex(S))
        #@info S
    end

    @assert ask(S) == 1
end

function main()
    T, N, Q = map(x -> parse(Int, x), split(readline()))
    for case in 1:T
        solve(N, Q)
    end
end

isinteractive() || main()
