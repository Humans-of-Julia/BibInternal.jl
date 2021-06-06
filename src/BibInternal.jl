module BibInternal

"""
Abstract entry supertype.
"""
abstract type AbstractEntry end

"""
`Fields = Dict{String, String}`. Stores the fields `name => value` of an entry.
"""
Fields = Dict{String,String}

# Includes
include("constant.jl")
include("utilities.jl")
include("bibtex.jl")
include("entry.jl")

end # module
