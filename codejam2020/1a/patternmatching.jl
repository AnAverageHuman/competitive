function process!(case, strs)
    fronts = findall(x -> x[1] != '*', strs)

    ends = findall(x -> x[end] != '*', strs)

    if length(fronts) > 2 || length(ends) > 2
        println("Case $(case): *")
        return
    end

    f = String[]

end


function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        N = parse(Int, readline(stdin))
        strs = String[readline(stdin) for _ in 1:N]

        process!(case, strs)
    end
end

isinteractive() || main()
