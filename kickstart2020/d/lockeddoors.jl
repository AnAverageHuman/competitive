function solve(case, N, Q, doors, queries)
    answers = Int[]
    for (Si, Ki) in queries
        left = Si - 1
        right = Si
        last = Si

        for _ in 2:Ki
            if right > N - 1 || (left > 0 && doors[left] < doors[right])
                left -= 1
                last = left + 1
            else
                right += 1
                last = right
            end
        end

        push!(answers, last)
    end

    println("Case #$(case): $(join(answers, " "))")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        N, Q = parse.(Int, stdin |> readline |> split)
        doors = parse.(Int, stdin |> readline |> split)

        queries = Tuple{Int,Int}[]
        for _ in 1:Q
            Si, Ki = parse.(Int, stdin |> readline |> split)
            push!(queries, (Si, Ki))
        end
        solve(case, N, Q, doors, queries)
    end
end

isinteractive() || main()
