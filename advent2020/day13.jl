module Day13

using Advent: save_input
using Mods: CRT, Mod, modulus

function solve_a(filename)
    open(filename) do io
        timestamp = parse(Int, readline(io))
        times = [parse(Int, x) for x in split(readline(io), ",") if x != "x"]

        minutes, i = findmin(times .- timestamp .% times)
        minutes * times[i]
    end
end

function solve_b(filename)
    line = readlines(filename)[2]
    times = (tryparse(Int, x) for x in split(line, ","))
    mods = (Mod(s - 1, t) for (s, t) in enumerate(times) if t !== nothing)
    res = CRT(mods...)
    modulus(res) - res.val
end

solve(filename = save_input(2020, 13)) = solve_a(filename), solve_b(filename)

end
