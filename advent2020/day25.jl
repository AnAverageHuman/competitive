module Day25
__revise_mode__ = :eval

using Advent: save_input

const m = 20201227

function loopsize(target)
    x = 1
    for i in Iterators.countfrom()
        x = rem(x * 7, m)
        x == target && return i
    end
end

function solve_a(filename)
    cpub, dpub = parse.(Int, readlines(filename))
    cloops = loopsize(cpub)
    dloops = loopsize(dpub)
    resd = powermod(dpub, cloops, m)
    resc = powermod(cpub, dloops, m)
    @assert resd == resc
    resd
end

solve_b(filename) = nothing

solve(filename = save_input(2020, 25)) = solve_a(filename), solve_b(filename)

end
