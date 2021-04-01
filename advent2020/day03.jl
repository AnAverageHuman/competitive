module Day3

using Advent: read_charmatrix, save_input

function slope(mat, (right, down))
    xs = 1:down:size(mat, 1)
    ys = range(1, step=right, length=length(xs))
    I = CartesianIndex.(xs, mod1.(ys, size(mat, 2)))
    count(c -> mat[c] == '#', I)
end

function solve_a(filename)
    mat = read_charmatrix(filename)
    slope(mat, (3, 1))
end

function solve_b(filename)
    mat = read_charmatrix(filename)
    slopes = ((1, 1), (3, 1), (5, 1), (7, 1), (1, 2))
    prod(Base.Fix1(slope, mat), slopes)
end

function solve_big(filename = "day3_big.in")
    mat = read_charmatrix(filename)
    right = (2, 3, 4, 6, 8, 9, 12, 16, 18, 24, 32, 36, 48, 54, 64)
    down = (1, 5, 7, 11, 13, 17, 19, 23, 25, 29, 31, 35, 37, 41, 47)
    prod(Base.Fix1(slope, mat), Iterators.product(right, down))
end

solve(filename = save_input(2020, 3)) = solve_a(filename), solve_b(filename)

end
