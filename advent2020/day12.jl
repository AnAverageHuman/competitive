module Day12

using Advent: save_input

# - Originally used tuples as coordinates but complex numbers are faster.
# - Better performance with ComplexF64 than Complex{Int64}.
# - Slight speedup but higher memory usage without @views when indexing strings.

function solve_a(filename)
    coord = 0.0 + 0im
    dir = 1.0 + 0im
    for line in eachline(filename)
        inst, arg = Symbol(line[1]), parse(Int, line[2:end])

        inst == :N && (coord += arg * im)
        inst == :S && (coord -= arg * im)
        inst == :E && (coord += arg)
        inst == :W && (coord -= arg)
        inst == :L && (dir *= im^div(arg, 90))
        inst == :R && (dir *= (-im)^div(arg, 90))
        inst == :F && (coord += dir * arg)
    end

    sum(abs, reim(coord)) |> Int
end

function solve_b(filename)
    coord = 0.0 + 0im
    waypoint = 10.0 + 1im
    for line in eachline(filename)
        inst, arg = Symbol(line[1]), parse(Int, line[2:end])

        inst == :N && (waypoint += arg * im)
        inst == :S && (waypoint -= arg * im)
        inst == :E && (waypoint += arg)
        inst == :W && (waypoint -= arg)
        inst == :L && (waypoint *= im^div(arg, 90))
        inst == :R && (waypoint *= (-im)^div(arg, 90))
        inst == :F && (coord += waypoint * arg)
    end

    sum(abs, reim(coord)) |> Int
end

solve(filename = save_input(2020, 12)) = solve_a(filename), solve_b(filename)

end
