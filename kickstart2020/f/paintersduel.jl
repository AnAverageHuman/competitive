# incomplete

EVEN_DIRS = [[0, -1], [0, 1], [-1, -1]]
ODD_DIRS = [[0, -1], [0, 1], [1, 1]]

validcoords(S, r, p) = 1 <= r <= S && 1 <= p <= 2S - 1

getcoords(R, P) = map(x -> [R, P] .+ x, iseven(P) ? EVEN_DIRS : ODD_DIRS)

function simulate(S, RA, PA, RB, PB, construction, painted)
    coordfilter(r, p) = validcoords(S, r, p) && !((r, p) in construction) && !((r, p) in painted[])

    Achecked = filter(x -> coordfilter(x...), getcoords(RA, PA))
    Bchecked = filter(x -> coordfilter(x...), getcoords(RB, PB))

    length(Achecked) == length(Bchecked) == 0 && return 0

    maxscore = 0
    if length(Achecked) > 0 && length(Bchecked) > 0
        for (ra, pa) in Achecked
            for (rb, pb) in Bchecked
                push!(painted[], (ra, pa))
                push!(painted[], (rb, pb))
                maxscore = max(maxscore, simulate(S, ra, pa, rb, pb, construction, painted))
                delete!(painted[], (ra, pa))
                delete!(painted[], (rb, pb))
            end
        end
    elseif length(Achecked) > 0
        for (ra, pa) in Achecked
            push!(painted[], (ra, pa))
            maxscore = max(maxscore, simulate(S, ra, pa, RB, PB, construction, painted)) + 1
            delete!(painted[], (ra, pa))
        end
    elseif length(Bchecked) > 0
        for (rb, pb) in Bchecked
            push!(painted[], (rb, pb))
            maxscore = max(maxscore, simulate(S, RA, PA, rb, pb, construction, painted)) - 1
            delete!(painted[], (rb, pb))
        end
    end

    maxscore
end

function solve(case, S, RA, PA, RB, PB, C, construction)
    score = simulate(S, RA, PA, RB, PB, construction, Ref(Set{Tuple{Int,Int}}()))
    println("Case $case: $score")
end

function main()
    T = parse(Int, readline(stdin))

    for case in 1:T
        S, RA, PA, RB, PB, C = parse.(Int, stdin |> readline |> split)

        construction = Set{Tuple{Int,Int}}()
        for _ in 1:C
            RI, PI = parse.(Int, stdin |> readline |> split)
            push!(construction, (RI, PI))
        end

        solve(case, S, RA, PA, RB, PB, C, construction)
    end
end

isinteractive() || main()
