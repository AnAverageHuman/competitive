let
       struct B; char::Char; hp::Int; end
       z = Matrix{B}(undef, 32,32)
       for (k,v) in readlines("day15.txt") |> enumerate
       for (k2,v2) in v |> enumerate
       z[k,k2] = B(v2, 200)
       end
       end
       i = 0
       while count(x -> x[1] in ['G', 'E'], z) > 0
       for x in 1:32, y in 1:32
       if z[x,y] in ['G', 'E']

