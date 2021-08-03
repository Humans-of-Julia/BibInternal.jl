using BibInternal
using Test

# TODO: make error testing for new version
#@test true

@testset "isless() for BibInternal.Date" begin

    @test BibInternal.Date("","","2000") < BibInternal.Date("","","2001");
    @test BibInternal.Date("","10","2000") < BibInternal.Date("","11","2000");
    @test BibInternal.Date("5","01","2000") < BibInternal.Date("15","01","2000");

    @test BibInternal.Date("","","1970") > BibInternal.Date("","","1969");
    @test BibInternal.Date("","7","1970") > BibInternal.Date("","6","1970");
    @test BibInternal.Date("7","7","1970") > BibInternal.Date("6","7","1970");

    @test BibInternal.Date("","","1805") == BibInternal.Date("","","1805");
    @test BibInternal.Date("","4","1805") == BibInternal.Date("","4","1805");
    @test BibInternal.Date("3","4","1805") == BibInternal.Date("3","4","1805");

    @test BibInternal.Date("","","1805") !== BibInternal.Date("","","1905");
    @test BibInternal.Date("","4","1805") !== BibInternal.Date("","5","1805");
    @test BibInternal.Date("3","4","1805") !== BibInternal.Date("4","4","1805");

    @test_skip BibInternal.Date("","May","1805") == BibInternal.Date("","5","1805");
    @test_skip BibInternal.Date("1th","5","1805") !== BibInternal.Date("1","5","1805");

    @test_throws ArgumentError BibInternal.Date("","","1") < BibInternal.Date("","","2000a");
    @test_throws ArgumentError BibInternal.Date("","","1") < BibInternal.Date("","","");
    @test_throws ArgumentError BibInternal.Date("","","1") < BibInternal.Date("","","90ies");
    @test_throws ArgumentError BibInternal.Date("","","40k") < BibInternal.Date("","","40000");

end

@testset "isless() for BibInternal.Name" begin
    # TODO: consider testing for alphabetizing rules

    @test BibInternal.Name("","Cow","","John","") < BibInternal.Name("","Doe","","John","");
    @test BibInternal.Name("","Doe","","John","A.") < BibInternal.Name("","Doe","","John","B.");
    @test BibInternal.Name("","Doe","","Bronn","") < BibInternal.Name("","Doe","","John","");
    @test BibInternal.Name("","Bronn","","Would","") < BibInternal.Name("","Bronn","","Would","Not");

    @test BibInternal.Name("","Doe","","John","") == BibInternal.Name("","Doe","","John","");
    @test BibInternal.Name("","Doe","jun.","John","") == BibInternal.Name("","Doe","jun.","John","");
    @test BibInternal.Name("","Doe","","John","E.") == BibInternal.Name("","Doe","","John","E.");

    @test BibInternal.Name("","Doe","","Bronn","") !== BibInternal.Name("","Doe","","John","");
    @test BibInternal.Name("","Doe","jun.","John","") !== BibInternal.Name("","Doe","sen.","John","");
    @test BibInternal.Name("","Doe","","John","E.") !== BibInternal.Name("","Doe","","John","A.");

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
