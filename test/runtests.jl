using BibInternal
using Test

@testset "BibInternal" begin
    include("sorting.jl")
    include("constants.jl")
end

@testset "junior parsing for BibInternal.Name" begin
    name = BibInternal.Name("Doe, Jr, Abe Brian")
    name_expected = BibInternal.Name("", "Doe", "Jr", "Abe", "Brian")
    @test name == name_expected

    name = BibInternal.Name("Doe, Jr., A. B.")
    name_expected = BibInternal.Name("", "Doe", "Jr.", "A.", "B.")
    @test name == name_expected

    # If no comma is used between the last name and junior, the junior should be
    # combined with the last name
    # (https://nwalsh.com/tex/texhelp/bibtx-23.html).
    name = BibInternal.Name("Doe Jr., A. B.")
    name_expected = BibInternal.Name("", "Doe Jr.", "", "A.", "B.")
    @test name == name_expected
end
