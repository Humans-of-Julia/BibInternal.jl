using Documenter, BibInternal

makedocs(
    sitename = "BibInternal.jl",
    authors = "Jean-François BAFFIER",
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true"
    ),
    pages = [
        "Home" => "index.md",
        "BibTeX" => "bibtex.md",
        "Utilities" => "utilities.md"
    ]
)

deploydocs(
    repo = "github.com/Azzaare/BibInternal.jl.git",
)
