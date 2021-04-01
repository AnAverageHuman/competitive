#!/usr/bin/env julia
using DelimitedFiles: readdlm

function solve(case, R, C, grid)
    numl = 0

    function is_l(R1, R2, C)
        0 < R1 <= size(grid, 1) && 0 < R2 <= size(grid, 1) && @views all(grid[R1:R2, C]) && (numl += 1; @info "" R1 R2 C)
    end


    for r in 1:R
        len = 0
        runr = 0
        runc = 0
        for c in 1:C
            if grid[r, c]
                len += 1
                len == 1 && (runr = r; runc = c)

                # looking for long
                for d in 2:len
                    is_l(runr, runr + 2d - 1, runc)
                    is_l(runr - 2d + 1, runr, runc)
                    is_l(r, r + 2d - 1, c)
                    is_l(r - 2d + 1, r, c)
                end

                # looking for short
                for d in 4:2:len
                    is_l(r, r + d ÷ 2 - 1, c)
                    is_l(r - d ÷ 2 + 1, r, c)
                    is_l(runr, runr + len ÷ 2 - 1, runc)
                    is_l(runr - len ÷ 2 + 1, runr, runc)
                end
            else
                len = 0
            end
        end
    end

    println("Case #$case: $numl")
end

function main()
    T = parse(Int, readline(stdin))

    for case in 1:T
        R, C = map(x -> parse(Int, x), split(readline(stdin)))
        grid = BitMatrix(undef, R, C)
        for r in 1:R
            grid[r,:] .= map(x -> parse(Bool, x), split(readline(stdin)))
        end
        @info "" grid
        solve(case, R, C, grid)
    end
end

isinteractive() || main()
