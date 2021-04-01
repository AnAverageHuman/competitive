struct Period
    st::Int
    en::Int
end
overlaps(a::Period, b::Period) = max(a.st, b.st) < min(a.en, b.en)

function process(case, timesltos)
    workers = Dict(:C => nothing, :J => nothing)
    res = []

    for minute in eachindex(periods)
        for k in keys(workers)
            # TODO
        end
    end

    if res
        println("Case #$(case): $(sol)")
    else
        println("Case #$(case): IMPOSSIBLE")
    end
end


function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        N = parse(Int, readline(stdin))
        timeslots = [Vector() for _ in 1:(24 * 60)]

        for _ in 1:N
            st, en = parse.(Int, stdin |> readline |> split)
            push!(timeslots[st], en)
        end

        process(case, timeslots)
        empty!(periods)
    end
end

isinteractive() || main()
