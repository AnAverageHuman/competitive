#!/usr/bin/env julia
module Ownway
using Printf: @printf

function create_movedict(lydiastr)
    current = [1, 1]
    movedict = Dict{Tuple{Int,Int},Char}()

    for c in lydiastr
        movedict[current...] = c
        current[c === 'E' ? 1 : 2] += 1
    end

    movedict
end

function solve_task(bsize, lydiastr)
    lydiamoves = create_movedict(lydiastr)
    is_solved(s) = length(s) == 2bsize - 2

    function solve_maze(x, y, moves)
        is_solved(moves) && x == y && return moves
        (x > bsize || y > bsize) && return moves[1:end - 1]
        lm = get(lydiamoves, (x, y), nothing)

        move_s() = solve_maze(x, y + 1, vcat(moves, 'S'))
        move_e() = solve_maze(x + 1, y, vcat(moves, 'E'))

        lm === 'E' && return move_s()
        lm === 'S' && return move_e()

        ret = move_e()
        is_solved(ret) && return ret
        return move_s()
    end

    return join(solve_maze(1, 1, Char[]), "")
end

function main()
    numtasks = parse(Int, readline())

    for i in 1:numtasks
        bsize = parse(Int, readline())
        lydiastr = readline()
        sol = solve_task(bsize, lydiastr)
        @printf "Case #%d: %s\n" i sol
    end
end
end

isinteractive() || Ownway.main()
