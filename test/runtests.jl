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
