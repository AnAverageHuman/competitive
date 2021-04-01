#!/usr/bin/env julia

using DelimitedFiles: writedlm
using LinearAlgebra: Diagonal


candidates(mat, idx) = @views setdiff(BitSet(1:size(mat[], 1)),
                                      BitSet(mat[][idx[1], :]), BitSet(mat[][:, idx[2]]))

function recursion2(mat, K)
    i = findfirst(==(0), mat[])
    i === nothing && return true

    for c in candidates(mat, i)
        mat[][i] = c
        recursion2(mat, K) && return true
        mat[][i] = 0
    end

    false
end

function recursion(fakediag, K)
    trace = fakediag[] |> sum
    trace > K && return false, nothing

    if trace == K
        mat = fakediag[] |> Diagonal |> Matrix |> Ref
        recursion2(mat, K) && return true, mat
    end

    i = findfirst(==(0), fakediag[])
    i === nothing && return false, nothing

    for ii in 1:min(length(fakediag[]), (K - trace - length(fakediag[]) + i))
        fakediag[][i] = ii
        res, mat = recursion(fakediag, K)
        res && return true, mat
    end

    fakediag[][i] = 0
    return false, nothing
end

function process(case, N, K)
    fakediag = Ref(zeros(Int, N))

    res, mat = recursion(fakediag, K)
    if res
        println("Case #$(case): POSSIBLE")
        writedlm(stdout, mat[], ' ')
    else
        println("Case #$(case): IMPOSSIBLE")
    end
end


function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        N, K = parse.(Int, stdin |> readline |> split)
        process(case, N, K)
    end
end

isinteractive() || main()
