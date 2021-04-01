module Day6

using Debugger

inp = Dict{String,String}()
for line in readlines("day6.e")
    a, b = split(line, ')')
    inp[b] = a # b is in orbit around a
end

function h(input, x)
    return (x in keys(input) ? union(h(input, input[x]), [x]) : [])
end

function solve(input)
    counts = Dict(k => h(input, k) for k in keys(input))

    sum(x -> length(x), values(counts)) # a

    a = counts["YOU"]
    b = counts["SAN"]
    while a[1] == b[1]
        @info a b
        deleteat!(a, 1)
        deleteat!(b, 1)
    end

    length(a) + length(b) - 2
end

end
