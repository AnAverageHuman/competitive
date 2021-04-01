let
       x = zeros(150, 150)
       carts = []
       mutable struct Cart
       dir::Int
       coord::Tuple{Int, Int}
       offset::Tuple{Int, Int}
       end
       #9
       d = Dict('^' => (0,1), 'v' => (0,-1), '<' => (-1,0), '>' => (1,0))
       mdirs = [(x, y) -> (y, -x), (x, y) -> (x, y), (x, y) -> (-y, x)]
       for (j, line) in eachline("day13.e") |> enumerate
       for (i, val) in split(line, "") |> enumerate
       val[1] in ['/' '\\' '+' '-' '|'] && (x[i,j] = 1)
       val[1] in ['^' 'v' '<' '>'] && push!(carts, Cart(3, (i, j), d[val[1]]))
       end
       end;
       while true;
       sort!(carts, by = x -> x.coord[2])
       for c in carts; @info c
       hasint = sum(x[max(1, c.coord[1] - 1): min(150, c.coord[1] + 1), max(1, c.coord[2] - 1): min(150, c.coord[2] + 1)]) > 3
       if hasint
       c.dir += 1; c.dir > 3 && (c.dir = 1)
       c.offset = mdirs[c.dir](c.offset...)
       else
       nc = c.coord .+ c.offset;
       if any(nc .> 150) || any(nc .< 1) || x[nc...] == 0; @info "here"
       for (z, i) in enumerate(mdirs);
       ncc = c.coord .+ i(c.offset...);
       (any(ncc .> 150) || any(ncc .< 1)) && continue
       x[ncc...] == 1 && (c.offset = i(c.offset...))
       end
       end
       end
       c.coord = c.coord .+ c.offset
       for cc in carts
       all(c.coord .== cc.coord) && c.offset != cc.offset && error(c.coord)
       end
       end
       end
       end
