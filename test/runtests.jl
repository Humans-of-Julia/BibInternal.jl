using BibInternal
using Test
import BibInternal.BibTeX

# TODO: make better error testing
try 
    BibInternal.BibTeX.Article("id", "", "", "", "", "")
catch e
    @test true
end