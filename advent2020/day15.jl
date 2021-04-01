module Day15
__revise_mode__ = :eval

using Advent: save_input

const my_input = [6,4,12,1,20,0,16]
const input_e1 = [0,3,6]

function simulate(input, rounds)
    last = input[end]
    times = Dict(x => i for (i, x) in enumerate(input))
    for curr in length(input):rounds - 1
        diff = curr - get!(times, last, curr)
        times[last] = curr
        last = diff
    end
    last
end

solve_a(input) = simulate(input, 2020)
solve_b(input) = simulate(input, 30000000)
solve(input = my_input) = solve_a(input), solve_b(input)

end
