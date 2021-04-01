module Day1

using Advent: save_input

function solve_a(filename, target)
    data = [parse(Int, i) for i in eachline(filename)]
    for i in Iterators.product(data, data)
        sum(i) == target && return prod(i)
    end
end

function solve_b(filename, target)
    data = [parse(Int, i) for i in eachline(filename)]
    for i in Iterators.product(data, data, data)
        sum(i) == target && return prod(i)
    end
end


solve(filename = save_input(2020, 1), t = 2020) = solve_a(filename, t), solve_b(filename, t)
solve_big() = solve("day1_big.in", 99920044)

end
