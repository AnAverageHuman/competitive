module Day11

using Advent: save_input, read_charmatrix

const directions = map(CartesianIndex, ((0, 1), (1, 0), (0, -1), (-1, 0), (1, 1), (-1, -1), (1, -1), (-1, 1)))

function count_occupied(A, I, limit)
    R = CartesianIndices(A)
    Ifirst, Ilast = first(R), last(R)
    I1 = oneunit(I)
    count(directions) do dir
        @inbounds for scale in Base.OneTo(limit)
            coord = muladd(dir, scale, I)
            checkbounds(Bool, A, coord) || return false
            A[coord] == '#' && return true
            A[coord] == 'L' && return false
        end
        false
    end
end

# the maximum number of neighbors a passenger will tolerate within distance
function stabilize(curr, tolerance, distance=maximum(size(curr)))
    prev = nothing
    while prev != curr
        prev = deepcopy(curr)
        for I in CartesianIndices(curr)
            prev[I] == 'L' && count_occupied(prev, I, distance) == 0         && (curr[I] = '#')
            prev[I] == '#' && count_occupied(prev, I, distance) >= tolerance && (curr[I] = 'L')
        end
    end
    count(==('#'), curr)
end

solve_a(filename) = stabilize(read_charmatrix(filename), 4, 1)
solve_b(filename) = stabilize(read_charmatrix(filename), 5)

solve(filename = save_input(2020, 11)) = solve_a(filename), solve_b(filename)
solve_big() = solve("day11_big.in")

end
