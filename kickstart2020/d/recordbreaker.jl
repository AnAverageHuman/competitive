function solve(case, N, days)
    record = 0
    breakers = 0
    for i in 1:N
        (i == 1 || days[i] > record) && (i == N || days[i] > days[i + 1]) && (breakers += 1)
        record = max(days[i], record)
    end

    println("Case #$(case): $(breakers)")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        N = parse(Int, readline(stdin))
        days = parse.(Int, stdin |> readline |> split)
        solve(case, N, days)
    end
end

isinteractive() || main()
