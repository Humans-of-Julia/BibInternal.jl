@testset "Code linting (JET.jl)" begin
    JET.test_package(BibInternal; target_defined_modules = true)
end
