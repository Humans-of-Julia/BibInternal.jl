using BibInternal
using Test
import BibInternal.BibTeX

fields = [
    ("title",
        "A (k+1)-approximation robust network flow algorithm and a tighter heuristic method using iterative multiroute flow"),
    ("author",
        "Baffier, Jean-Fran{\\c{c}}ois and Suppakitpaisarn, Vorapong"),
    ("booktitle", "International Workshop on Algorithms and Computation"),
    ("pages", "68--79"),
    ("year", "2014"),
    ("organization", "Springer International Publishing")
]

entry = BibInternal.Entry(
    "inproceedings",
    "baffier2014k+",
    fields
)

println(entry)

println(typeof(BibInternal.bibtex_rules))

try 
    BibInternal.BibTeX.Article("", "", "", "", "")
catch e
    @test true
end