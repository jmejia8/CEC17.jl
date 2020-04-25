# CEC17

A wrapper for the CEC17 competition benchmark for Julia 1.x

## Installation

Using the Pkg environment:

```
pkg> add https://github.com/jmejia8/CEC17.jl
```

## Examples

Unconstrained optimization:

```julia
x = rand(10)
for fnum in 1:30
  f = cec17_test_func(x, fnum)
  @show f
end
```



Constrained optimization:

```julia
x = rand(10)
for fnum in 1:30
  f, g, h = cec17_test_COP(x, fnum)
  @show f
  @show g
  @show h
end
```
