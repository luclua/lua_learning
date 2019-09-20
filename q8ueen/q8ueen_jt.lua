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
        if not is_place_ok(a, i, a[i]) do
            return false
        end
    end
    return true
end

function print_sln(a)
    for i = 1, N do
        for j = 1, N do
            io.write(a[i] == j and "X" or "-")
        end
        io.write("\n")
    end
    io.write("\n")
end

function gen_all_perms(a)
    n = #a
    b = c = {}

    for i = 1, n do b[i] = 0; c[i] = 1 end

    i = 1
    j = n
    s = 0

    perms[i] = a
    
    while true do
        ::redo::
        q = b[j] + c[j]
        if q >= 0 and q ~= j + 1 do
            i = i + 1
            a[j - b[j] + s], a[j - q + s] = a[j - q + s], a[j - b[j] + s]
            perms[i] = a
            b[j] = q
            j = n
            s = 0
            goto redo
        end

        if q == j + 1 do
            if j == 1 do
                break
            else
                s = s + 1
            end
        end

        c[j] = -c[j]
        j = j - 1
    end
end

function find_queens_sln()
    for i = 1, #perms do
        if not is_perm_ok(perms[i]) do
            table.remove(perms, i)
        end
    end
end

function solve_n_queens(a)
    gen_all_perms(a)
    find_queens_sln()
    io.write("the number of n queens problem's solutions is %d\n", #perms)
    for i = 1, #perms do
        print_sln(perms[i])
    end
end

solve_n_queens({1, 2, 3, 4, 5, 6, 7, 8})







