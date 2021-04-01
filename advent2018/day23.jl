module Day23

using LinearAlgebra

inp = Dict()

for line in eachline("day23.txt")
    m = match(r"pos=<(\-?\d+(\.\d+)?),(\-?\d+(\.\d+)?),(\-?\d+(\.\d+)?)>, r=(\d+)", line)
    m = [parse(Int, i) for i in m.captures if i !== nothing]
    inp[[m[1], m[2], m[3]]] = m[4] # pos => r
end

function solvea()
    r, coord = findmax(inp)
    count(x -> norm(x - coord, 1) <= r, keys(inp))
end

function solveb()
    #unfinished
    tmpmat = hcat(keys(inp)...)
    extrema(tmpmat; dims = 2) |> Iterators.product
end

end
