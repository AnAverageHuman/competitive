module Day8

using Advent: save_input

struct Instruction
    op::Symbol
    arg::Int
    Instruction(op::Union{AbstractString,Symbol}, arg::Int) = new(Symbol(op), arg)
end

function parse_instructions(filename)
    insts = Instruction[]
    open(filename) do io
        while !eof(io)
            op, arg = readuntil(io, ' '), parse(Int, readline(io))
            push!(insts, Instruction(op, arg))
        end
    end
    insts
end

function simulate!(insts)
    pos = 1
    acc = 0
    seen = BitSet()
    while checkbounds(Bool, insts, pos) && !(pos in seen)
        push!(seen, pos)
        inst = insts[pos]
        inst.op == :acc && (acc += inst.arg; pos += 1)
        inst.op == :jmp && (pos += inst.arg)
        inst.op == :nop && (pos += 1)
    end
    (pos == length(insts) + 1, acc)
end

function solve_a(filename)
    _, res = filename |> parse_instructions |> simulate!
    res
end

function solve_b(filename)
    insts = parse_instructions(filename)
    for (i, inst) in enumerate(insts)
        if inst.op in (:jmp, :nop)
            save = insts[i]
            insts[i] = Instruction((insts[i].op == :jmp ? :nop : :jmp), insts[i].arg)
            success, res = simulate!(insts)
            success && return res
            insts[i] = save
        end
    end
    -1
end

solve(filename = save_input(2020, 8)) = solve_a(filename), solve_b(filename)

end
