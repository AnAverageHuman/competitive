function solve(case, H)
    c = count(enumerate(H)) do (i, h)
        i != firstindex(H) && i != lastindex(H) && H[i - 1] < H[i] > H[i + 1]
    end

    println("Case #$(case): $c")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        _ = parse(Int, readline(stdin))
        H = parse.(Int, split(readline(stdin)))
        solve(case, H)
    end
end

isinteractive() || main()
