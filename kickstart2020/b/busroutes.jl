function solve(case, D, X)
    earliest = D
    for i in Iterators.reverse(X)
        earliest = div(earliest, i) * i
    end

    println("Case #$(case): $(earliest)")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        _, D = parse.(Int, split(readline(stdin)))
        X = parse.(Int, split(readline(stdin)))
        solve(case, D, X)
    end
end

isinteractive() || main()
