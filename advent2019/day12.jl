module Day12


moons = Dict(enumerate([[-13, 14, -7], [-18, 9, 0], [0, -3, -3], [-15, 3, -13]]))

potenergy(moon) = sum(abs, moon)
kinenergy(vel) = sum(abs, vel)
totalenergy(m, v) = sum(potenergy.(values(m)) .* kinenergy.(values(v)))

function step!(moons, velocities)
    for i in 1:4, j in 1:4
        i == j && continue
        velocities[i] .+= Int.(map(sign, moons[j] .- moons[i]))
    end

    for k in keys(moons)
        moons[k] .+= velocities[k]
    end
end

function solvea(moons)
    velocities = Dict(i => [0, 0, 0] for i in 1:4)
    for _ in 1:1000
        step!(moons, velocities)
    end

    totalenergy(moons, velocities)
end

function solveb(moons)
    velocities = Dict(i => [0, 0, 0] for i in 1:4)
    seen = [Set(), Set(), Set()]
    stop = falses(3)

    while ! all(stop)
        vals = vcat(values(moons)..., values(velocities)...) |> x -> reshape(x, :, 8)
        for axis in 1:3
            if ! stop[axis]
                vals[axis, :] in seen[axis] && (stop[axis] = true)
                push!(seen[axis], vals[axis, :])
            end
        end
        step!(moons, velocities)
    end

    reduce(lcm, length.(seen))
end

end
