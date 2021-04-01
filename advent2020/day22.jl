module Day22
__revise_mode__ = :eval

using Advent: save_input, eachlinegroup

function read_input(filename)
    Vector{Int}[
        [parse(Int, x) for x in Iterators.drop(group, 1)]
        for group in eachlinegroup(filename)
    ]
end

deck_score(deck) = sum(prod, deck |> Iterators.reverse |> enumerate)

function solve_a(filename)
    groups = read_input(filename)
    while !any(isempty, groups)
        nums = popfirst!.(groups)
        low, high = extrema(nums)
        push!(groups[argmax(nums)], high, low)
    end

    Iterators.filter(!isempty, groups) |> only |> deck_score
end


function play_game!(groups)
    seen = Set{UInt64}()
    while !any(isempty, groups)
        h = reduce(hash, Iterators.map(hash, groups))
        h in seen && return 1
        push!(seen, h)

        nums = popfirst!.(groups)

        if all(length(groups[i]) >= n for (i, n) in enumerate(nums))
            winner = play_game!([groups[i][1:n] for (i, n) in enumerate(nums)])
            push!(groups[winner], popat!(nums, winner), only(nums))
        else
            low, high = extrema(nums)
            push!(groups[argmax(nums)], high, low)
        end
    end
    findmax(groups)[2]
end

function solve_b(filename)
    groups = read_input(filename)
    winner = play_game!(groups)
    deck_score(groups[winner])
end

solve(filename = save_input(2020, 22)) = solve_a(filename), solve_b(filename)

end
