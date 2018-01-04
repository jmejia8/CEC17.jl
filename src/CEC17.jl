module CEC17

    export cec17_test_func
    export cec17_test_COP
    const localDir = string(@__DIR__)
    const LIB = "$localDir/cfunctions.so"
    const LIB_COP = "$localDir/cfunctions_cop.so"


    function cec17_test_func(x::Vector, func_num::Int)

        D = length(x)
        f = [0.0]

        ccall((:func, LIB), Void, (Ptr{Cdouble},
                                   Ptr{Cdouble},
                                   Ptr{Cchar},
                                   Int32, Int32, Int32),
                                   x, f, localDir, D, 1, func_num)
        return f[1]
    end

    function cec17_test_COP(x::Vector, func_num::Int)

        D = length(x)
        f = [0.0]
        g = [0.0]
        h = [0.0]

        ccall((:func, LIB_COP), Void, (Ptr{Cdouble},
                                   Ptr{Cdouble},
                                   Ptr{Cdouble},
                                   Ptr{Cdouble},
                                   Ptr{Cchar},
                                   Int32, Int32, Int32),
                                   x, f, g, h, localDir, D, 1, func_num)
        return f[1], g[1], h[1]
    end

end # module