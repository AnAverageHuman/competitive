module Day8

using StatsBase

inp = readline("day8.e") |> Vector{Char} |> x -> parse.(Int8, x)
inp = reshape(inp, 25, 6, :)

function solvea()
    maxlayer = 0
    layer = argmin(count.(==(0), eachslice(inp; dims = 3)))
    counts = countmap(inp[:, :, layer])
    counts[1] * counts[2]
end

function solveb()
    ans = zeros(Int, 25, 6)
    for i in 1:25, j in 1:6
        slice = inp[i, j, :]
        ans[i, j] = slice[findfirst(!=(2), slice)]
    end

    transpose(ans)
end

end
