module Day7

using Advent: save_input

struct Bag
    color::AbstractString
    quant::Int
end

function parse_rules(filename)
    rules = Dict{String, Vector{Bag}}()
    for line in eachline(filename)
        color, rest = split(line, r" bags contain ")
        rawrules = eachmatch(r"(\d+) (\w+ \w+) bag", rest)
        rules[color] = [
            Bag.(color, parse(Int, quant))
            for (quant, color) in Iterators.map(x -> x.captures, rawrules)
        ]
    end
    rules
end

function resolve(rules, color)
    color == "shiny gold" || any(cc -> resolve(rules, cc.color), rules[color])
end

function solve_a(filename)
    rules = parse_rules(filename)
    count(keys(rules)) do color
        color != "shiny gold" && resolve(rules, color)
    end
end

function resolve2(rules, color)
    if length(rules[color]) > 0
        1 + sum(cc -> cc.quant * resolve2(rules, cc.color), rules[color])
    else
        1
    end
end

function solve_b(filename)
    rules = parse_rules(filename)
    resolve2(rules, "shiny gold") - 1
end

solve(filename = save_input(2020, 7)) = solve_a(filename), solve_b(filename)

end
