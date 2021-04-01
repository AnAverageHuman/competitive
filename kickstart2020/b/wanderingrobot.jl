function recsolve!(x, y, lu, rd, memo)
    any((x, y) .> size(memo[])) && return 0
    ismissing(memo[][x, y]) || return memo[][x, y]
    
    if x == size(memo[], 1)
        memo[][x, y] = recsolve!(x, y + 1, lu, rd, memo)
    elseif y == size(memo[], 2)
        memo[][x, y] = recsolve!(x + 1, y, lu, rd, memo)
    else
        rs = recsolve!(x, y + 1, lu, rd, memo) + recsolve!(x + 1, y, lu, rd, memo)
        memo[][x, y] = rs / 2
    end

    memo[][x, y]
end

function solve(case, wh, lu, rd)
    memo = Array{Union{Missing,Rational}}(missing, wh)
    memo[lu[1]:rd[1], lu[2]:rd[2]] .= Rational(0)
    memo[wh...] = Rational(1)

    p = recsolve!(1, 1, lu, rd, Ref(memo)) |> Float64
    println("Case #$(case): $p")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        W, H, L, U, R, D = parse.(Int, split(readline(stdin)))
        solve(case, (W, H), (L, U), (R, D))
    end
end

isinteractive() || main()
