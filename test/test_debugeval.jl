load("debug.jl")

module TestTrap
using Base, Debug
import Debug.trap



@debug function f(n)
    x = 0       # line 10
    for k=1:n   # line 11
        x += k  # line 12
    end         # line 13
    x = x*x     # line 14
    x
end

function trap(line::Int, file, scope::Scope) 
    print(line, ":")

    if (line == 11) debug_eval(scope, :(x = x+1)) end

    if (line > 10)  print("\tx = ", debug_eval(scope, :x)) end
    if (line == 12) print("\tk = ", debug_eval(scope, :k)) end
    println()
end

f(3)

end
