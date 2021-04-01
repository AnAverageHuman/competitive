function solve(U, queries)

end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        U = parse(Int, readline(stdin))
        queries = Vector{String}(missing, 10^4)
        for i in 1:10^4
            _, R = stdin |> readline |> split
            queries[i] = R
        end

        solve(case, U, queries)
    end
end

isinteractive() || main()
