#!/usr/bin/env julia

function process(case, dgs)
    stack = Int[0]
    ret = Union{Int,String}[]
    for digit in dgs
        diff = digit - stack[end]

        if diff != 0
            pop!(stack)
            push!(stack, digit)
        end

        diff > 0 && push!(ret, '('^diff)
        diff < 0 && push!(ret, ')'^-diff)
        push!(ret, digit)
    end

    push!(ret, ')'^stack[end])
    nested = join(ret, "")
    println("Case #$(case): $(nested)")
end

function main()
    T = parse(Int, readline(stdin))
    for case in 1:T
        dgs = parse.(Int, split(readline(stdin), ""))
        process(case, dgs)
    end
end

isinteractive() || main()
