function solve(case, N, D, A)
    dict = Dict{Rational,Int}()
    for a in A
        dict[a] = get(dict, a, 0) + 1
    end

    cuts = 0
    while max(values(dict)) < D

    end

    println("Case #$(case): $(cuts)")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        N, D = parse.(Int, stdin |> readline |> split)
        A = parse.(Int, stdin |> readline |> split)
        solve(case, N, D, A)
    end
end

isinteractive() || main()
