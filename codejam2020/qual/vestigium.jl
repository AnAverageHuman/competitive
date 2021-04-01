#!/usr/bin/env julia

using DelimitedFiles: readdlm
using LinearAlgebra: tr

function process(case, mat)
    rr = 0
    cc = 0

    for r in eachrow(mat)
        length(BitSet(r)) < size(mat, 1) && (rr += 1)
    end

    for c in eachcol(mat)
        length(BitSet(c)) < size(mat, 1) && (cc += 1)
    end

    trace = tr(mat)
    println("Case #$(case): $(trace) $(rr) $(cc)")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        N = parse(Int, readline(stdin))
        mat = Matrix{Int}(undef, N, N)

        for i in 1:N
            mat[i, :] .= parse.(Int, stdin |> readline |> split)
        end

        #mat = readdlm(stdin, Int; dims = (N, N))
        process(case, mat)
    end
end

isinteractive() || main()
