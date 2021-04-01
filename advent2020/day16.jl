module Day16

using Advent: save_input
using Base: Fix1

function parse_file(filename)
    open(filename) do io
        ruledict = Dict{String, Vector{UnitRange}}()
        for line in eachline(io)
            line == "" && break
            rulename, rulevals = split(line, r": ")
            vals = split(rulevals, r" or ")
            ruledict[rulename] = [parse(Int, i):parse(Int, j) for (i, j) in split.(vals, "-")]
        end

        readline(io)
        your = parse.(Int, split(readline(io), ","))
        readline(io)
        readline(io)
        nearby = map(x -> parse.(Int, x), split.(eachline(io), ","))

        ruledict, your, nearby
    end
end

function solve_a(filename)
    ruledict, _, nearby = parse_file(filename)
    rules = Iterators.flatten(values(ruledict))
    sum(n for n in Iterators.flatten(nearby) if all(Fix1(!in, n), rules))
end

function recurse(dict, tocheck)
    isempty(tocheck) && return dict

    if any(isempty, values(dict)) || length(union(values(dict))) < length(dict)
        return empty(dict)
    end

    k = popfirst!(tocheck)
    for j in dict[k]
        save = deepcopy(dict)
        dict[k] = Set(j)
        for (k2, v2) in dict
            k == k2 || setdiff!(v2, dict[k])
        end
        res = recurse(dict, tocheck)
        isempty(res) || return res
        dict = save
    end
    return empty(dict)
end

function solve_b(filename)
    ruledict, your, _nearby = parse_file(filename)
    rules = Iterators.flatten(values(ruledict))
    nearby = filter(ticket -> all(n -> any(Fix1(in, n), rules), ticket), _nearby)

    possible = Dict(
        rulename => Set(
            Iterators.filter(1:length(your)) do j
                all(ticket -> any(Fix1(in, ticket[j]), rulevals), nearby) 
            end
        )
        for (rulename, rulevals) in ruledict
    )

    tocheck = sort!(collect(keys(possible)); by=x -> length(possible[x]))
    actual = recurse(possible, tocheck)
    prod(your[only(v)] for (rule, v) in actual if startswith(rule, "departure"))
end

solve(filename = save_input(2020, 16)) = solve_a(filename), solve_b(filename)

end
