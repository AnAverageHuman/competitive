module Day10

using LinearAlgebra

function readdata(s)
    sidelen = s |> length |> sqrt |> Int
    Set((j - 1, i) for i in 0:sidelen - 1, j in 1:sidelen if s[i * sidelen + j] == '#')
end

asteroids = read("day10.e", String) |> x -> replace(x, "\n" => "") |> readdata

angle(pos, other) = atan(other[2] - pos[2], other[1] - pos[1])

function numseen(asteroids, pos)
    slopes = Set()
    count(asteroids) do other
        (other == pos || angle(pos, other) in slopes) && return false
        push!(slopes, angle(pos, other))
        return true
    end
end

solvea(asteroids) = argmax(Dict(x => numseen(asteroids, x) for x in asteroids))

function solveb(asteroids) #incomplete
    start = solvea(asteroids)
    asts = [(x, angle(start, x)) for x in asteroids if x != start]
    sort!(asts, by = x -> x[2])
    ang = -pi / 2
    nextval = findfirst(x -> x[2] >= ang, asts) # straight up
    for _ in 1:199
        idxs = findall(x -> x[2] == asts[nextval][2], asts)
        idx = argmin([x -> (x, norm(start .- asts[x][1])) for x in idxs])
        idx == nothing && (idx = 1)
        ang = asts[idx[1]][2]
        @info asts[idx]
        splice!(asts, idx)
    end

    asts[idx]
end

end
