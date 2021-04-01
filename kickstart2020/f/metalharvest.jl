function solve(case, N, K, times)
    deployments = 0
    endtime = 0

    for (S, E) in sort(times)
        if endtime < E
            start = max(S, endtime)
            todeploy = ceil(Int, (E - start) / K)
            deployments += todeploy
            endtime = start + todeploy * K
        end
    end

    println("Case #$case: $deployments")
end


function main()
    T = parse(Int, readline(stdin))

    for case in 1:T
        N, K = parse.(Int, stdin |> readline |> split)

        times = []
        for i in 1:N
            S, E = parse.(Int, stdin |> readline |> split)
            push!(times, (S, E))
        end

        solve(case, N, K, times)
    end
end

isinteractive() || main()
