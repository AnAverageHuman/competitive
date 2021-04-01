module Day20
__revise_mode__ = :eval

using Advent: save_input, eachlinegroup, read_charmatrix

function read_input(filename)
    tiles = Dict{Int,Matrix{Char}}()
    open(filename) do io
        buf = []
        num = nothing
        line = nothing
        while !eof(io)
            line = readline(io)
            line == "" && (tiles[num] = mapreduce(collect, hcat, buf); num = nothing; empty!(buf); continue)
            num == nothing && (num = parse(Int, line[6:9]); continue)
            push!(buf, line)
        end
    end
    @info tiles
    tiles
end

function get_borders(mat)
    Set((mat[1:end, 1], mat[1, 1:end], mat[end, 1:end], mat[1:end, end]))
end

function solve_a(filename)
    tiles = read_input(filename)
    borders = Dict(k => get_borders(v) for (k, v) in tiles)
    counts = Dict(
        k => count(tile) do t
            any(borders) do b
                (t in b.second || reverse(t) in b.second) && k != b.first
            end
        end
        for (k, tile) in borders
    )
    prod(findall(==(2), counts))
end

remove_borders(mat) = mat[2:end-1, 2:end-1]

function solve_b(filename)
    # not solved
    tiles = read_input(filename)
    borders = Dict(k => get_borders(v) for (k, v) in tiles)
    counts = Dict(
        k => count(tile) do t
            any(borders) do b
                (t in b.second || reverse(t) in b.second) && k != b.first
            end
        end
        for (k, tile) in borders
    )
    prod(findall(==(2), counts))
end

solve(filename = save_input(2020, 20)) = solve_a(filename), solve_b(filename)

end
