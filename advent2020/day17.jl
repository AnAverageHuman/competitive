module Day17
__revise_mode__ = :eval

using Advent: save_input, read_charmatrix

function countoccupied(S, I)
    I1 = oneunit(I)
    count(J -> (I != J) && J in S, I - I1:I + I1)
end

function simulate(S)
    next = deepcopy(S)
    low, high = extrema(S)
    I1 = oneunit(low)
    for I in low - I1:high + I1
        c = countoccupied(S, I)
        if I in S 
            c != 2 && c != 3 && pop!(next, I)
        else
            c == 3 && push!(next, I)
        end
    end
    next
end

function read_input(filename, ndims=3)::Set{CartesianIndex}
    layer = read_charmatrix(filename)
    A = reshape(layer, (size(layer)..., ntuple(_ -> 1, ndims - 2)...))
    Set(findall(==('#'), A))
end

function solve(filename, ndims, rounds = 6)
    S = read_input(filename, ndims)
    for _ in 1:rounds
        S = simulate(S)
    end
    length(S)
end

solve_a(filename) = solve(filename, 3)
solve_b(filename) = solve(filename, 4)

solve(filename = save_input(2020, 17)) = solve_a(filename), solve_b(filename)

end
