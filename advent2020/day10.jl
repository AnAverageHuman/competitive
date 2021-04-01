module Day10

using Advent: save_input
using DataStructures: CircularBuffer

function get_jolts(filename)
    nums = [parse(Int, x) for x in eachline(filename)] |> sort!
    pushfirst!(nums, 0)
    push!(nums, nums[end] + 3)
end

function solve_a(filename)
    nums = get_jolts(filename) |> diff
    count(==(1), nums) * count(==(3), nums)
end

function solve_b(filename)
    nums = get_jolts(filename)
    memo = CircularBuffer{Int}(3)
    append!(memo, [1, 1, 1])
    for i in (lastindex(nums) - 3):-1:1
        push!(memo, sum(memo[4 - j] for j in Base.OneTo(3) if (nums[i + j] - nums[i]) < 4))
    end
    memo[end]
end

solve(filename = save_input(2020, 10)) = solve_a(filename), solve_b(filename)

end
