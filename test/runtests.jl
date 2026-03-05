using BibInternal

using Aqua
using ExplicitImports
using Test
using TestItemRunner

const JET_AVAILABLE = try
    using JET
    true
catch
    false
end
@show JET_AVAILABLE

@testset "Package tests: BibInternal" begin
    include("Aqua.jl")
    include("ExplicitImports.jl")
    if JET_AVAILABLE
        include("JET.jl")
    end
    include("TestItemRunner.jl")
end
