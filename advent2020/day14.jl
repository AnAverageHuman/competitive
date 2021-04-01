module Day14

using Advent: save_input

function solve_a(filename)
    memory = Dict{Int,UInt}()
    mask0 = nothing
    mask1 = nothing
    for line in eachline(filename)
        left, right = split(line, r" = ")
        if left == "mask"
            mask0 = reduce((x, y) -> (x << 1) | (y != '0'), right, init = zero(UInt64))
            mask1 = reduce((x, y) -> (x << 1) | (y == '1'), right, init = zero(UInt64))
        else
            address = parse(Int, left[5:end - 1])
            value = parse(UInt, right)
            memory[address] = value & mask0 | mask1
        end
    end
    memory |> values |> sum |> Int
end

function solve_b(filename)
    memory = Dict{Int,UInt}()
    mask1 = nothing
    maskf = nothing
    for line in eachline(filename)
        left, right = split(line, r" = ")
        if left == "mask"
            maskf = reduce((x, y) -> (x << 1) | (y == 'X'), right, init = zero(UInt64))
            mask1 = reduce((x, y) -> (x << 1) | (y == '1'), right, init = zero(UInt64))
        else
            address = parse(Int, left[5:end - 1]) & ~maskf | mask1
            value = parse(UInt, right)
            st = maskf
            while st != 0
                # cycle through bits in the mask
                memory[address | st] = value
                st = (st - 1) & maskf
            end
        end
    end
    memory |> values |> sum
end

solve(filename = save_input(2020, 14)) = solve_a(filename), solve_b(filename)
solve_big() = solve("day14_big.in")

end
