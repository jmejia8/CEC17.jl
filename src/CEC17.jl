module CEC17

    export cec17_test_func
    const localDir = string(@__DIR__)
    const LIB = "$localDir/cfunctions.so"


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

end # module