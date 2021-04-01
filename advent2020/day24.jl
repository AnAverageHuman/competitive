module Day24
__revise_mode__ = :eval

using Advent: save_input

const OFFSETS_1 = Dict(
    'e' => CartesianIndex(+1, -1, +0), 
    'w' => CartesianIndex(-1, +1, +0),
)

const OFFSETS_2 = Dict(
    "se" => CartesianIndex(+0, -1, +1),
    "sw" => CartesianIndex(-1, +0, +1),
    "nw" => CartesianIndex(+0, +1, -1),
    "ne" => CartesianIndex(+1, +0, -1),
)

const OFFSETS = union(values(OFFSETS_1), values(OFFSETS_2))
const OFFSETS_self = union(OFFSETS, [CartesianIndex(+0, +0, +0)])

function getcoord(path)
    i = 1
    coord = CartesianIndex(0, 0, 0)
    @inbounds while i <= length(path)
        if path[i] == 'e' || path[i] == 'w'
            coord += OFFSETS_1[path[i]]
            i += 1
        else
            coord += OFFSETS_2[path[i:i + 1]]
            i += 2
        end
    end
    coord
end

function parse_input(filename)
    black = Set{CartesianIndex{3}}()
    for line in eachline(filename)
        c = getcoord(line)
        c in black ? pop!(black, c) : push!(black, c)
    end
    black
end

function solve_a(filename)
    filename |> parse_input |> length
end

countoccupied(S, I) = @inbounds count(O -> I + O in S, OFFSETS)

function simulate(S)
    next = deepcopy(S)
    low, high = extrema(S)
    for I in S, O in OFFSETS_self
        n = I + O
        c = countoccupied(S, n)
        if n in next 
            (c == 0 || c > 2) && pop!(next, n)
        else
            c == 2 && push!(next, n)
        end
    end
    next
end

function solve_b(filename)
    black = parse_input(filename)
    for _ in 1:100
        black = simulate(black)
    end
    length(black)
end

solve(filename = save_input(2020, 24)) = solve_a(filename), solve_b(filename)

end
