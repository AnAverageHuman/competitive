#!/usr/bin/env julia
using DelimitedFiles: readdlm

function solve(case, R, C, grid)
    seen = BitMatrix(undef, size(grid)...)
    added = 0

    function propagate(I)
        checkbounds(Bool, grid, I) || return
        seen[I] && return

        maxc = zero(I)
        maxneighbor = 0
        neighbors = Ref(I) .+ CartesianIndex.([(0, 1), (1, 0), (0, -1), (-1, 0)])
        for _I in neighbors
            checkbounds(Bool, grid, _I) || continue
            candidate = grid[I] - grid[_I]
            if candidate > maxneighbor
                maxneighbor = candidate
                maxc = _I
            end
        end
        iszero(maxc) && return
        grid[maxc] = grid[I] - 1
        seen[I] = true
        added += abs(maxneighbor) - 1

        for neighbor in neighbors
            propagate(neighbor)
        end
    end

    maxval, _ = findmax(grid)
    maxinds = findall(==(maxval), grid)

    for maxind in maxinds
        propagate(maxind)
    end

    println("Case #$case: $added")
end

function main()
    T = parse(Int, readline(stdin))

    for case in 1:T
        R, C = map(x -> parse(Int, x), split(readline(stdin)))
        grid = Matrix{Int}(undef, R, C)
        for r in 1:R
            grid[r,:] .= map(x -> parse(Int, x), split(readline(stdin)))
        end
        solve(case, R, C, grid)
    end
end

isinteractive() || main()
