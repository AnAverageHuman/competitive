f(v) = let x = 0; for i in v
        while i > 0
            i = max(2, trunc(i / 3)) - 2
            x += i
        end
    end; x
end
