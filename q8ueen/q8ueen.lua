#!/usr/bin/env lua

-------------------------------------------------
-- Eight Queens Problem in Backtracking 
--
-- from Programming in Lua (Edition 4)
--
-- Tue Sep 17 21:02:46 CST 2019
-------------------------------------------------

N = 8
sln_n = 0
sln_s = {}


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


function p_sln(a)
    for i = 1, N do
        for j = 1, N do
            io.write(a[i] == j and "X" or "-", " ")
        end
        io.write("\n")
    end
    io.write("\n")
end


function add_queen(a, n)
    if n > N then
        sln_n = sln_n + 1
        sln_s[sln_n] = {}
        for i = 1, N do                 -- deepcopy
            sln_s[sln_n][i] = a[i]
        end
    else
        for c = 1, N do
            if is_place_ok(a, n, c) then
                a[n] = c
                add_queen(a, n + 1)
            end
        end
    end
end
    

function p_sln_s(n)
    io.write(string.format("num of eight queens problem's solutions is %d\n", sln_n))
    io.write(string.format("first %d solutions are:\n", n))
    for i = 1, n do
        p_sln(sln_s[i])
    end
end
    
add_queen({}, 1)
p_sln_s(2)

