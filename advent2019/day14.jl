module Day14


function readinput(fn)
    reactions = Dict()
    for l in eachline(fn)
        inp, outp = split(l, " => ")
        inps = ((x[2], parse(Int, x[1])) for x in split.(split(inp, ", "), ' '))
        outnum, outchem = split(outp, " ")
        outnum = parse(Int, outnum)
        reactions[outchem] = (outnum, inps)
    end
    reactions
end

reactions = readinput("day14.e") # key: output, value: (num output, ((input, num input), ...))

function getndeps(d, symb, numneeded)
    symb == "ORE" && return numneeded
    numcreated, deps = d[symb]

    # incomplete: needs to account for extra chemicals
    Int(ceil(numneeded / numcreated)) * sum(getndeps(d, s, n) for (s, n) in deps)
end




end
