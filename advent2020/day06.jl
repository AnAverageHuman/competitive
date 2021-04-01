module Day6

using Advent: save_input, eachlinegroup

# use codeunits. and BitSet for a slight performance gain over Vector{Char} and Set

function solve_a(filename)
    sum(eachlinegroup(filename)) do group
        codeunits.(group) |> Iterators.flatten |> BitSet |> length
    end
end

function solve_b(filename)
    sum(eachlinegroup(filename)) do group
        reduce(intersect, BitSet.(codeunits.(group))) |> length
    end
end

solve(filename = save_input(2020, 6)) = solve_a(filename), solve_b(filename)

end
