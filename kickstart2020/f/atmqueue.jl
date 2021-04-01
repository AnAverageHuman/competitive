function solve(case, N, X, A)
    AA = Channel{Tuple{Int,Int}}(N)
    foreach(x -> put!(AA, x), enumerate(A[]))
    dequeued = []
    while !isempty(AA)
        (i, person) = take!(AA)
        person -= X
        if person <= 0
            push!(dequeued, i)
        else
            put!(AA, (i, person))
        end
    end

    println("Case #$case: $(join(dequeued, " "))")
end


function main()
    T = parse(Int, readline(stdin))

    for case in 1:T
        N, X = parse.(Int, stdin |> readline |> split)
        A = parse.(Int, stdin |> readline |> split)
        solve(case, N, X, Ref(A))
    end
end

isinteractive() || main()
