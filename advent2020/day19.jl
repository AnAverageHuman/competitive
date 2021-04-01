module Day19
__revise_mode__ = :eval

# day 2 not solved

using Advent: save_input

function validstr(line, dict, rule)
    isempty(line) && return (true, "")
    rule isa Char && return (line[1] == rule ? (true, line[2:end]) : (false, line))
    res = line
    for r in dict[rule]
        res = line
        k = true
        for pos in r
            (ok, res) = validstr(res, dict, pos)
            k = ok
            res == line && (ok = false; break)
        end
        k == true && return (true, res)
    end
    return (false, line)
end

function solve_a(filename)
    open(filename) do io
        rules = Dict{Int, Vector{Vector{Union{Char,Int}}}}()
        for line in eachline(io)
            line == "" && break
            num, vals = split(line, ": ")
            vals = split(vals, " | ")
            rules[parse(Int, num)] = [((v[1][1] == '"') ? map(x -> x[2], v) : parse.(Int, v)) for v in split.(vals)]
        end

        count(eachline(io)) do line
            empty!(rcounts)
            x, y = validstr(line, rules, 0)
            x && isempty(y)
        end
    end
end

function solve_b(filename)
end

solve(filename = save_input(2020, 19)) = solve_a(filename), solve_b(filename)

end
