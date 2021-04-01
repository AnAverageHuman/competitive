module Day4

using Advent: eachlinegroup, save_input
using Base.Iterators: map # shadows Base.map

const fields = Set(("byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"))
isvalid(passport) = issubset(fields, keys(passport))

function parse_passports(filename)
    passports = Set(
        Dict{String,String}(
            k => v
            for (k, v) in map(Base.Fix2(split, ":"), Iterators.flatten(map(split, group)))
        )
        for group in eachlinegroup(filename)
    )

    filter!(isvalid, passports)
end

solve_a(filename) = filename |> parse_passports |> length

function validate_passport(current)
    (parse(Int, current["byr"]) in 1920:2002) && 
    (parse(Int, current["iyr"]) in 2010:2020) && 
    (parse(Int, current["eyr"]) in 2020:2030) && 
    (
        (current["hgt"][end - 1:end] == "cm" && parse(Int, current["hgt"][1:end-2]) in 150:193) ||
        (current["hgt"][end - 1:end] == "in" && parse(Int, current["hgt"][1:end-2]) in 59:76)

    ) &&
    match(r"^#[0-9a-f]{6}$", current["hcl"]) !== nothing &&
    current["ecl"] in ("amb", "blu", "brn", "gry", "grn", "hzl", "oth") &&
    match(r"^[0-9]{9}$", current["pid"]) !== nothing
end

function solve_b(filename)
    count(parse_passports(filename)) do current
        try
            validate_passport(current)
        catch
            false
        end
    end
end

solve(filename = save_input(2020, 4)) = solve_a(filename), solve_b(filename)
solve_big() = solve("day4_big.in")

end
