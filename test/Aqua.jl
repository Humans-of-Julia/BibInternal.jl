@testset "Aqua.jl" begin
    # TODO: Fix the broken tests and remove the `broken = true` flag
    Aqua.test_all(
        BibInternal;
        ambiguities = (broken = false,),
        deps_compat = false,
        piracies = (broken = false,)
    )

    @testset "Ambiguities: BibInternal" begin
        Aqua.test_ambiguities(BibInternal;)
    end

    @testset "Piracies: BibInternal" begin
        Aqua.test_piracies(BibInternal;)
    end

    @testset "Dependencies compatibility (no extras)" begin
        Aqua.test_deps_compat(
            BibInternal;
            check_extras = false            # ignore = [:Random]
        )
    end
end
