module Day7

using Combinatorics
using OffsetArrays

_inp = [3,8,1001,8,10,8,105,1,0,0,21,38,59,84,93,110,191,272,353,434,99999,3,9,101,5,9,9,1002,9,5,9,101,5,9,9,4,9,99,3,9,1001,9,3,9,1002,9,2,9,101,4,9,9,1002,9,4,9,4,9,99,3,9,102,5,9,9,1001,9,4,9,1002,9,2,9,1001,9,5,9,102,4,9,9,4,9,99,3,9,1002,9,2,9,4,9,99,3,9,1002,9,5,9,101,4,9,9,102,2,9,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,99]

inp = OffsetVector(_inp, 0:length(_inp) - 1) # convert to 0-based index

function simulate(v, inc, outc)
    i = 0
    function getop()
        opcode = v[i] % 100
        modes = convert(Vector{Bool}, digits(div(v[i], 100), pad = 3))
        return opcode, modes
    end

    getval(modes, idx) = modes[idx] ? v[i + idx] : v[v[i + idx]]

    function rtype(op, modes)
        v[v[i + 3]] = op(getval(modes, 1), getval(modes, 2))
        i += 4
    end

    jtype(op, modes) = i = op(getval(modes, 1), 0) ? getval(modes, 2) : i + 3

    function itype(op, modes)
        v[v[i + 3]] = Int(op(getval(modes, 1), getval(modes, 2)))
        i += 4
    end

    while true
        opcode, modes = getop()

        opcode in 1:8 || return
        opcode == 1 && rtype(+, modes)
        opcode == 2 && rtype(*, modes)
        opcode == 5 && jtype(!=, modes)
        opcode == 6 && jtype(==, modes)
        opcode == 7 && itype(<, modes)
        opcode == 8 && itype(==, modes)

        if opcode == 3
            v[v[i + 1]] = take!(inc)
            i += 2
        elseif opcode == 4
            put!(outc, v[v[i + 1]])
            i += 2
        end
    end
end

function simulateamp(v, p)
    io = [Channel(2) for i in 1:5]
    put!.(io, p)
    put!(first(io), 0) # seed
    amps = [Threads.@spawn simulate(copy(v), io[i], io[mod1(i + 1, 5)]) for i in 1:5]

    wait.(amps)
    return take!(first(io))
end

solvea(v) = maximum(p -> simulateamp(v, p), permutations(0:4))
solveb(v) = maximum(p -> simulateamp(v, p), permutations(5:9))

end
