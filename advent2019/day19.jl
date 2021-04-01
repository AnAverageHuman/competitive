module Day19

using SparseArrays

_inp = [109,424,203,1,21102,11,1,0,1106,0,282,21101,18,0,0,1106,0,259,1202,1,1,221,203,1,21101,31,0,0,1105,1,282,21101,0,38,0,1106,0,259,20101,0,23,2,22101,0,1,3,21102,1,1,1,21102,57,1,0,1105,1,303,2102,1,1,222,21002,221,1,3,21001,221,0,2,21101,0,259,1,21101,80,0,0,1106,0,225,21101,0,149,2,21101,91,0,0,1106,0,303,1202,1,1,223,21002,222,1,4,21102,1,259,3,21101,225,0,2,21101,0,225,1,21101,118,0,0,1106,0,225,21001,222,0,3,21102,1,58,2,21102,1,133,0,1106,0,303,21202,1,-1,1,22001,223,1,1,21101,148,0,0,1105,1,259,1201,1,0,223,21002,221,1,4,20102,1,222,3,21101,21,0,2,1001,132,-2,224,1002,224,2,224,1001,224,3,224,1002,132,-1,132,1,224,132,224,21001,224,1,1,21102,195,1,0,105,1,109,20207,1,223,2,20102,1,23,1,21101,0,-1,3,21102,1,214,0,1106,0,303,22101,1,1,1,204,1,99,0,0,0,0,109,5,2101,0,-4,249,22101,0,-3,1,21201,-2,0,2,22101,0,-1,3,21101,250,0,0,1106,0,225,22101,0,1,-4,109,-5,2106,0,0,109,3,22107,0,-2,-1,21202,-1,2,-1,21201,-1,-1,-1,22202,-1,-2,-2,109,-3,2105,1,0,109,3,21207,-2,0,-1,1206,-1,294,104,0,99,22101,0,-2,-2,109,-3,2106,0,0,109,5,22207,-3,-4,-1,1206,-1,346,22201,-4,-3,-4,21202,-3,-1,-1,22201,-4,-1,2,21202,2,-1,-1,22201,-4,-1,1,22101,0,-2,3,21101,0,343,0,1105,1,303,1105,1,415,22207,-2,-3,-1,1206,-1,387,22201,-3,-2,-3,21202,-2,-1,-1,22201,-3,-1,3,21202,3,-1,-1,22201,-3,-1,2,22102,1,-4,1,21102,1,384,0,1105,1,303,1105,1,415,21202,-4,-1,-4,22201,-4,-3,-4,22202,-3,-2,-2,22202,-2,-4,-4,22202,-3,-2,-3,21202,-4,-1,-2,22201,-3,-2,1,21202,1,1,-4,109,-5,2105,1,0]

inp = Dict(zip(0:length(_inp) - 1, Ref.(_inp))) # convert to 0-based index

newref() = Ref(0)

function simulate!(v, inc, outc)
    i = 0
    relbase = 0

    function getval(modes, idx)
        modes[idx] == 0 && return get!(newref, v, v[i + idx][])
        modes[idx] == 1 && return get(v, i + idx, 0)
        modes[idx] == 2 && return get!(newref, v, relbase + v[i + idx][])
    end

    while true
        opcode, modes = v[i][] % 100, digits(div(v[i][], 100), pad = 3)

        function rtype!(op)
            getval(modes, 3)[] = op(getval(modes, 1)[], getval(modes, 2)[])
            i += 4
        end

        jtype!(op) = i = op(getval(modes, 1)[], 0) ? getval(modes, 2)[] : i + 3

        function itype!(op)
            getval(modes, 3)[] = Int(op(getval(modes, 1)[], getval(modes, 2)[]))
            i += 4
        end

        opcode in 1:9 || return
        opcode == 1 && rtype!(+)
        opcode == 2 && rtype!(*)
        opcode == 5 && jtype!(!=)
        opcode == 6 && jtype!(==)
        opcode == 7 && itype!(<)
        opcode == 8 && itype!(==)

        if opcode == 3
            getval(modes, 1)[] = take!(inc)
            i += 2
        elseif opcode == 4
            put!(outc, getval(modes, 1)[])
            i += 2
        elseif opcode == 9
            relbase += getval(modes, 1)[]
            i += 2
        end
    end
end

function solvea(v)
    inc, outc = Channel(2), Channel(1)

    cnt = 0
    for x in 0:49, y in 0:49
        put!(inc, x)
        put!(inc, y)
        simulate!(deepcopy(v), inc, outc)
        cnt += take!(outc)
    end

    cnt
end

function solveb(v) #incomplete
    inc, outc = Channel(2), Channel(1)

    x, y = 99900, 99900
    mat = spzeros(10000, 10000)
    seen = Set()
    reasons = []

    while true
        length(reasons) == 2 && return x * 10000 + y

        for i in x:x + 100, j in y:y + 100
            (i, j) in seen && continue
            t = Threads.@spawn simulate!(deepcopy(v), inc, outc)
            put!(inc, x)
            put!(inc, y)
            push!(seen, (i, j))
            mat[i, j] = take!(outc)

        end


    end


    for x in 0:601, y in 0:601
    end

    for x in 0:500, y in 0:500
        sum(mat[x:x + 100, y:y + 100]) == 10000 && return x * 10000 + y
    end
end

end
