function findneighbor(square, ci, dir)
    if dir == :L
        res = findlast(x -> x > 0, square[1:ci[1] - 1, ci[2]])
        res !== nothing && return CartesianIndex(res, ci[2])
    elseif dir == :R
        res = findfirst(x -> x > 0, square[ci[1] + 1:end, ci[2]])
        res !== nothing && return CartesianIndex(ci[1] + res, ci[2])
    elseif dir == :D
        res = findlast(x -> x > 0, square[ci[1], 1:ci[2] - 1])
        res !== nothing && return CartesianIndex(ci[1], res)
    elseif dir == :U
        res = findfirst(x -> x > 0, square[ci[1], ci[2] + 1:end])
        res !== nothing && return CartesianIndex(ci[1], ci[2] + res)
    end

    return nothing
end

const dirs = (:L, :R, :D, :U)

function process!(case, square)
    total_interest = 0

    while true
        next_square = copy(square)
        total_interest += sum(square)
        tocheck = findall(x -> x > 0, square)
        length(tocheck) > 0 || break

        for ci in tocheck
            neighbor_skill = 0
            neighbors = 0

            for dir in dirs
                cn = findneighbor(square, ci, dir)

                if cn !== nothing
                    neighbors += 1
                    neighbor_skill += square[cn]
                end
            end

            if neighbors > 0 && neighbor_skill / neighbors > square[ci]
                next_square[ci] = 0
            end
        end

        square == next_square && break
        square = next_square
    end

    println("Case #$(case): $(total_interest)")
end


function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        R, C = parse.(Int, stdin |> readline |> split)
        square = Matrix{Int}(undef, R, C)
        for i in 1:R
            square[i, :] = parse.(Int, stdin |> readline |> split)
        end

        process!(case, square)
    end
end

isinteractive() || main()
