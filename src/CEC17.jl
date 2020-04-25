module CEC17

    export cec17_test_func, cec17_test_COP,searchRange

    if isfile(joinpath(dirname(@__FILE__),"..","deps","deps.jl"))
        include("../deps/deps.jl")
    else
        error("This test function suit is not properly installed. Please run Pkg.build(\"CEC17\")")
    end

    const localDir = joinpath(string(@__DIR__), "..", "deps", "usr", "lib")
    # const LIB = "$localDir/cfunctions.so"
    # const LIB_COP = "$localDir/cfunctions_cop.so"
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
        if D ∉ [2, 10, 30, 50, 100] || func_num ∉ 1:30
            error("D ∉ [2, 10, 30, 50, 100] or func_num ∉ 1:30")
            return NaN
        end
        if D == 2 && func_num ∉ 1:10
            error("if D == 2 then func_num in 1:10")
            return NaN
        end


        f = [0.0]

        ccall((:cec17_func, optimizationBenchmark), Cvoid, (Ptr{Cdouble},
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

        ccall((:cec17_func, constrainedOptimizationBenchmark), Cvoid, (Ptr{Cdouble},
                                   Ptr{Cdouble},
                                   Ptr{Cdouble},
                                   Ptr{Cdouble},
                                   Ptr{Cchar},
                                   Int32, Int32, Int32),
                                   x, f, g, h, localDir, D, 1, func_num)
        return f[1], g, h
    end

end # module
