module Day18
__revise_mode__ = :eval

using Advent: save_input, read_charmatrix
#using Tokenize: Tokens, tokenize, untokenize
#
#function make_tokens(tokens)
#    [(Tokens.kind(x) == Tokens.INTEGER ? parse(Int, untokenize(x)) : untokenize(x)) for x in tokens if Tokens.kind(x) != Tokens.WHITESPACE]
#end
#
#function eval_expr(expr)
#    left = popfirst!(expr)
#    if left == "("
#        eval_expr(expr)
#        left = popfirst!(expr)
#        popfirst!(expr) # )
#    end
#    isempty(expr) && return left
#
#    op = popfirst!(expr)
#    op == ")" && return left
#    op == "" && return left
#    op = Symbol(op)
#
#    right = popfirst!(expr)
#    if right == "("
#        eval_expr(expr)
#        right = popfirst!(expr)
#        popfirst!(expr) # )
#    end
#
#    res = eval(:( $op($left, $right) ))
#
#    if isempty(expr)
#        res
#    else
#        pushfirst!(expr, res)
#        expr[2] == ")" && return
#        eval_expr(expr)
#    end
#end

⊗(x, y) = x + y
⊕(x, y) = x * y

function solve_a(filename)
    #sum(x -> eval_expr(make_tokens(tokenize(x))), eachline(filename))
    sum(eachline(filename)) do line
        # same precedence
        replace(line, "*" => "⊕") |> Meta.parse |> eval
    end
end

function solve_b(filename)
    sum(eachline(filename)) do line
        replace(line, "+" => "⊗") |> x -> replace(x, "*" => "⊕") |> Meta.parse |> eval
    end
end

solve(filename = save_input(2020, 18)) = solve_a(filename), solve_b(filename)

end
