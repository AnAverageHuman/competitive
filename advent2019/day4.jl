module Day4

using StatsBase

a = 124075
b = 580769

function solve(a, b)
    numfound = 0
    for i in a:b
        i = string(i)
        cond = true
        cond2 = false
        for j in 2:length(i)
            if i[j - 1] > i[j]
                cond = false
                break
            end
        end

        if cond
            m = countmap(Vector{Char}(i))
            (2 in values(m)) && (numfound += 1)
        end
    end

    numfound
end

end
