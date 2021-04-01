while true
       start = 0
       space = 110
       x = fill('.', space)
       i = 0

       d = Dict{String,Char}()
       open("day12.txt") do f
       for (k,v) in enumerate(split(readline(f), ""))
       x[1, k + 5] = v[1]
       end
       for line in eachline(f)
       d[line[1:5]] = line[7]
       end
       end
       y = deepcopy(x)

       while i < 50000000000
       x = deepcopy(y)
       y = fill('.', space)
       for j in 1:146
       b = string(x[j:j + 4]...)
       y[j + 2] = (b in keys(d) ? d[b] : '.')
       end

       if any(==('#'), y[1:4])
       space += 2; start -= 2
       else
       space -= 2; start += 2
       any(==('#'), y[end - 4:end]) && (space += 2)


       end; s = 0
       for i in 1:150
       x[21,i] == '#' && (s += i - 26)
       end; s
       i += 1; i > 50000000000 && break
