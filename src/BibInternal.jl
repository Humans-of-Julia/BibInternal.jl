module BibInternal

# Abstract Entry type
abstract type AbstractEntry end

# Fields: Dict of name => value
Fields = Dict{String, String}

# Includes
include("constant.jl")
include("utilities.jl")
include("bibtex.jl")
include("entry.jl")

end # module
