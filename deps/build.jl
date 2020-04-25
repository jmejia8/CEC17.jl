if VERSION < v"0.7.0" && Pkg.installed("BinDeps") == nothing
    Pkg.add("BinDeps")
end

using BinDeps
using Libdl

@BinDeps.setup

version = "1.0.0"
optimizationBenchmark = library_dependency("optimizationBenchmarkJulia", aliases=["benchmark-$version"], os = :Unix)
constrainedOptimizationBenchmark = library_dependency("constrainedOptimizationBenchmarkJ", aliases=["constrained-benchmark-$version"], os = :Unix)

# build from source
provides(Sources,
        URI("https://github.com/jmejia8/cec-benchmark/archive/v$(version).zip"),
        unpacked_dir="cec-benchmark-$version",
        optimizationBenchmark)

# provides(BuildProcess, Autotools(libtarget = "libgsl.la"), benchmark)

prefix = joinpath(BinDeps.depsdir(optimizationBenchmark), "usr")
srcdir = joinpath(BinDeps.srcdir(optimizationBenchmark), "cec-benchmark-$version")

lib_path = joinpath(prefix, "lib")

unconstrained = joinpath(prefix, "lib", "benchmark-$(version).$(Libdl.dlext)")
constrained   = joinpath(prefix, "lib", "constrained-benchmark-$(version).$(Libdl.dlext)")

provides(SimpleBuild,
    (@build_steps begin
        GetSources(optimizationBenchmark)
        CreateDirectory(lib_path)
        @build_steps begin
            ChangeDirectory(srcdir)
            MAKE_CMD
            `mv benchmark.$(Libdl.dlext) "$(unconstrained)"`
        end
    end), [optimizationBenchmark], os = :Unix)

provides(SimpleBuild,
    (@build_steps begin
        @build_steps begin
            `mv constrained_benchmark.$(Libdl.dlext) "$(constrained)"`
        end
    end), [ constrainedOptimizationBenchmark ], os = :Unix)


@BinDeps.install Dict(:optimizationBenchmarkJulia => :optimizationBenchmark, :constrainedOptimizationBenchmarkJ => :constrainedOptimizationBenchmark)
