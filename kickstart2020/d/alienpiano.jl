function solve(case, pitches)
    streak = 1
    dir = nothing
    last = pitches[1]
    broken = 0

    for elem in pitches[2:end]
        if elem > last
            dir == :D && (streak = 1)
            dir = :U
        elseif elem < last
            dir == :U && (streak = 1)
            dir = :D
        end

        if elem != last
            if streak >= 4
                streak = 0
                broken += 1
            end

            streak += 1
        end

        last = elem
    end

    println("Case #$(case): $(broken)")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        K = parse(Int, readline(stdin))
        pitches = parse.(Int, stdin |> readline |> split)
        solve(case, pitches)
    end
end

isinteractive() || main()
