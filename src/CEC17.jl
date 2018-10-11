module CEC17

    export cec17_test_func, cec17_test_COP,searchRange
    
    const localDir = string(@__DIR__)
    const LIB = "$localDir/cfunctions.so"
    const LIB_COP = "$localDir/cfunctions_cop.so"
    const ng_A = [1,1,1,2,2,1,1,1,1,1,1,2,3,1,1,1,1,2,2,2,2,3,1,1,1,1,2,2]
    const nh_A = [1,1,1,1,1,6,2,2,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] 

    function searchRange(n::Int) # n = function number
        if n in [4,5,9]
            return [-10.0, 10.0]

        elseif n in [7,19,28]
            return [-50.0, 50.0]

        elseif n == 6
            return [-20.0, 20.0]
        end

        return [-100.0, 100.0]
    end

    function cec17_test_func(x::Array{Float64}, func_num::Int)

        D = length(x)
        f = [0.0]

        ccall((:func, LIB), Cvoid, (Ptr{Cdouble},
                                   Ptr{Cdouble},
                                   Ptr{Cchar},
                                   Int32, Int32, Int32),
                                   x, f, localDir, D, 1, func_num)
        return f[1]
    end

    function cec17_test_COP(x::Array{Float64}, func_num::Int)
        D = length(x)
        f = [0.0]
        g = zeros(ng_A[func_num])
        h = zeros(nh_A[func_num])

        ccall((:func, LIB_COP), Cvoid, (Ptr{Cdouble},
                                   Ptr{Cdouble},
                                   Ptr{Cdouble},
                                   Ptr{Cdouble},
                                   Ptr{Cchar},
                                   Int32, Int32, Int32),
                                   x, f, g, h, localDir, D, 1, func_num)
        return f[1], g, h
    end

end # module