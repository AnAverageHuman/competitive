module Day23
__revise_mode__ = :eval

my_input = 643719258
input_e1 = 389125467

# linkedlist as array: cups[i] is the label of the cup that comes after the cup labeled i
 
function make_cups(input, to = length(input))
    cups = Vector{Int}(undef, to)

    for i in 2:length(input)
        cups[input[i - 1]] = input[i]
    end
    for i in length(input) + 1:to - 1
        cups[i] = i + 1
    end

    if length(input) == to
        cups[input[end]] = input[1]
    else
        cups[input[end]] = length(input) + 1
        cups[end] = input[1]
    end

    cups
end

function simulate!(cups, curr)
    cup1 = cups[curr]
    cup2 = cups[cup1]
    cup3 = cups[cup2]
    cup4 = cups[cup3]

    dest = mod1(curr - 1, length(cups))
    while dest == cup1 || dest == cup2 || dest == cup3
        dest = mod1(dest - 1, length(cups))
    end
    cups[curr] = cup4
    cups[cup3] = cups[dest]
    cups[dest] = cup1

    cup4
end

function solve_a(input)
    inp = input |> digits |> reverse
    cups = make_cups(inp)
    curr = inp[1]
    for _ in 1:100
        curr = simulate!(cups, curr)
    end

    out = cups[1]
    prev = cups[1]
    while cups[prev] != 1
        out = muladd(out, 10, cups[prev])
        prev = cups[prev]
    end
    out
end

function solve_b(input)
    inp = input |> digits |> reverse
    cups = make_cups(inp, 1000000)
    curr = inp[1]
    for _ in 1:10000000
        curr = simulate!(cups, curr)
    end

    cup1 = cups[1]
    cup1 * cups[cup1]
end

solve(input = my_input) = solve_a(input), solve_b(input)

end
