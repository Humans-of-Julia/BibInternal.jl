@testset "Constants" begin
    @test BibInternal.maxfieldlength == 13
    @info "Collections: " BibInternal.fields BibInternal.entries
    @test BibInternal.Fields == Dict{String,String}
end
