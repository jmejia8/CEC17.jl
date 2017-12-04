module CEC17

    export testFunc

    function testFunc(x::Vector, func_num)

        lib = joinpath(@__DIR__, "cfunctions.so")

        D = length(x)
        f = [0.0]

        ccall((:func, lib), Void, (Ptr{Cdouble},
                                   Ptr{Cdouble},
                                   Int32, Int32, Int32),
                                   x, f, D, 1, func_num)
        return f[1]
    end

end # module
