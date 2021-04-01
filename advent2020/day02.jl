module Day2

using Advent: save_input

const regex = r"([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)$"

function parse_line(line)
    low, high, letter, password = match(regex, line).captures
    parse(Int, low), parse(Int, high), only(letter), password
end

function solve_a(filename)
    count(eachline(filename)) do line
        low, high, letter, password = parse_line(line)
        count(==(letter), password) in low:high
    end
end

function solve_b(filename)
    count(eachline(filename)) do line
        low, high, letter, password = parse_line(line)
        (password[low] == letter) ⊻ (password[high] == letter)
    end
end

solve(filename = save_input(2020, 2)) = solve_a(filename), solve_b(filename)

end
