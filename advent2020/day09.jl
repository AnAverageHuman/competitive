module Day9

using Advent: save_input

function _solve_a(nums, preamble=25)
    for i in (preamble + 1):lastindex(nums)
        found = any(Iterators.product(i - 25:i, i - 25:i)) do (j, k)
            nums[i] == nums[j] + nums[k] && j != k
        end
        found || return nums[i]
    end
    big(-1)
end

function solve_a(filename)
    nums = map(x -> parse(BigInt, x), eachline(filename))
    _solve_a(nums)
end

function solve_b(filename)
    nums = map(x -> parse(BigInt, x), eachline(filename))
    target = _solve_a(nums)
    for i in eachindex(nums), j in i + 2:lastindex(nums)
        @views sum(nums[i:j]) == target && return sum(extrema(nums[i:j]))
    end
    big(-1)
end

solve(filename = save_input(2020, 9)) = solve_a(filename), solve_b(filename)

end
