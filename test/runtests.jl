using CEC17
using Test

# write your own tests here
function test1()

    s = 0.0
    for f in 1:10
        for d in [10, 30, 50, 100]
            s += cec17_test_func(rand(d), f)
        end
    end

    s
end

function test2()

    s = 0.0
    for f in 1:10
        for d in [10, 30]
            a, b, c = cec17_test_COP(rand(d), f)
            s += a + sum(a) + sum(c)
        end
    end

    s
end

@test  test1() > 0.0
@test  test2() > 0.0
