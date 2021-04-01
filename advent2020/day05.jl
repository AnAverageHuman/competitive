module Day5

using Advent: save_input

get_seatnum(line) = reduce((x, y) -> (x << 1) | (y == 'R') | (y == 'B'), line; init = 0)

solve_a(filename) = maximum(get_seatnum, eachline(filename))

function solve_b(filename)
    seats = Iterators.map(get_seatnum, eachline(filename)) |> BitSet
    low, high = extrema(seats)
    setdiff(BitSet(low:high), seats)
end

solve(filename = save_input(2020, 5)) = solve_a(filename), solve_b(filename)
solve_big() = solve("day5_big.in")

end
