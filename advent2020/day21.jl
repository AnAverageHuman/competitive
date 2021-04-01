module Day21
__revise_mode__ = :eval

using Advent: save_input
using DataStructures: counter, inc!

function recurse(dict::Dict{S, Set{T}}, tocheck::Vector{S}) where S where T
    isempty(tocheck) && return dict
    sort!(tocheck; by=x -> length(dict[x]))

    if any(isempty, values(dict)) || length(union(values(dict))) < length(dict)
        return empty(dict)
    end

    k = popfirst!(tocheck)
    for j in dict[k]
        save = deepcopy(dict)
        dict[k] = Set([j])
        for (k2, v2) in dict
            k == k2 || setdiff!(v2, dict[k])
        end
        res = recurse(dict, tocheck)
        isempty(res) || return res
        merge!(dict, save)
    end
    return empty(dict)
end

function parse_input(filename)
    possible = Dict{String,Set{String}}()
    ingred_counts = counter(String)
    for line in eachline(filename)
        _ingreds, _allers = split(line, "(contains ")
        ingreds = split(_ingreds)
        map(Base.Fix1(inc!, ingred_counts), ingreds)

        allers = Set(split(_allers[1:end-1], ", "))
        for aller in allers
            intersect!(get!(possible, aller, Set(ingreds)), ingreds)
        end
    end

    possible, ingred_counts
end

function solve_a(filename)
    possible, ingred_counts = parse_input(filename)
    bad = reduce(union, values(possible))
    sum(v for (k, v) in ingred_counts if !(k in bad))
end

function solve_b(filename)
    possible, _ = parse_input(filename)
    tocheck = possible |> keys |> collect
    bad = Dict(k => only(v) for (k, v) in recurse(possible, tocheck))
    join((bad[k] for k in sort(collect(keys(possible)))), ",")
end

solve(filename = save_input(2020, 21)) = solve_a(filename), solve_b(filename)

end
