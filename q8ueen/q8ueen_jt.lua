#!/usr/bin/env lua

-------------------------------------------------------
--  Eight Queens Problem in Johnson-Trotter algorithm
--
-------------------------------------------------------

N = 8
perms = {}


function is_place_ok(a, n, c)
    for i = 1, n - 1 do 
        if a[i] == c or
            a[i] - i == c - n or
            a[i] + i == c + n then
            return false
        end
    end
    return true
end


function is_perm_ok(a)
    for i = 1, N do
        if not is_place_ok(a, i, a[i]) then
            return false
        end
    end
    return true
end


function print_sln(a)
    for i = 1, N do
        for j = 1, N do
            io.write(a[i] == j and "X " or "- ")
        end
        io.write("\n")
    end
    io.write("\n")
end


function gen_all_perms(a)
    n = #a

    b = {}
    c = {}

    for i = 1, n do b[i] = 0; c[i] = 1 end

    i = 1
    j = n
    s = 0

    perms[i] = {}
    for k = 1, #a do
        perms[i][k] = a[k]
    end
    
    while true do
        ::redo::
        q = b[j] + c[j]
        if q >= 0 and q ~= j then
            a[j - b[j] + s], a[j - q + s] = a[j - q + s], a[j - b[j] + s]

            i = i + 1
            perms[i] = {}
            for k = 1, #a do
                perms[i][k] = a[k]
            end

            b[j] = q
            j = n
            s = 0
            goto redo
        end

        if q == j then
            if j == 1 then
                break
            else
                s = s + 1
            end
        end

        c[j] = -c[j]
        j = j - 1
    end
end


function find_queens_sln(a)
    gen_all_perms(a)

    k = 0
    for i = 1, #perms do
        if is_perm_ok(perms[i]) then
            k = k + 1
            io.write(string.format("the %dth solution of 8 queens problem:\n", k))
            print_sln(perms[i])
        end
    end
end


find_queens_sln({1, 2, 3, 4, 5, 6, 7, 8})

