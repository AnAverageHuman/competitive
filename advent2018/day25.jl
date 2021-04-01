module Day25

using LinearAlgebra

inp = Set()
for line in eachline("day25.txt")
    push!(inp, line |> strip |> x -> split(x, ',') |> x -> parse.(Int, x))
end

mandist(a, b) = norm(a - b, 1)

function solvea(v)
    #incomplete
    consts = Set()

    function addstar(star)
        for constellation in consts, existstar in constellation
            if mandist(existstar, star) <= 3
                push!(constellation, star)
                return
            end
        end

        push!(consts, [star])
    end

    for star in sort(collect(v))
        addstar(star)
    end

    length(consts)
end

end
